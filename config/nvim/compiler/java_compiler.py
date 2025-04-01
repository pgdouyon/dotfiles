#!/usr/bin/env python3

import os
import sys
import subprocess
import re
import json
import time
import argparse
import logging
from dataclasses import dataclass
from typing import Optional, List, Dict

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger(__name__)


# Configuration
@dataclass
class Config:
    CACHE_DIR: str = os.path.join(
            os.environ.get('XDG_CACHE_HOME', os.path.expanduser('~/.cache')),
            'java_compiler')
    CACHE_FILE: str = os.path.join(CACHE_DIR, 'cache.json')
    CACHE_EXPIRY: int = 3600  # 1 hour in seconds
    VIM_TARGET_DIR: str = 'vim_target'
    MAVEN_CLASSPATH_PATTERN: str = r'classpath:\n([^[]+)\n'
    BAZEL_JAR_PATTERN: str = r'bazel-out.*\.jar'


class CacheManager:
    """Manages the classpath cache operations."""

    def __init__(self, config: Config):
        self.config = config

    def load(self) -> Dict:
        """Load the classpath cache from file."""
        if not os.path.exists(self.config.CACHE_FILE):
            return {}
        try:
            with open(self.config.CACHE_FILE, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, IOError) as e:
            logger.debug(f"Failed to load cache: {e}")
            return {}

    def save(self, cache: Dict) -> None:
        """Save the classpath cache to file."""
        os.makedirs(os.path.dirname(self.config.CACHE_FILE), exist_ok=True)
        try:
            with open(self.config.CACHE_FILE, 'w') as f:
                json.dump(cache, f)
        except IOError as e:
            logger.debug(f"Failed to save cache: {e}")

    def get_key(self, file_path: str) -> str:
        """Generate a cache key for the given file."""
        proj_root = ProjectInfo.get_root(file_path)
        is_test = ProjectInfo.is_test_file(file_path)
        module = ProjectInfo.get_module_name(proj_root)
        return f"{proj_root}:{module}:{'test' if is_test else 'main'}"

    def is_valid(self, cache_entry: Dict) -> bool:
        """Check if a cache entry is still valid."""
        if not cache_entry:
            return False
        elapsed_time = time.time() - cache_entry.get('timestamp', 0)
        return elapsed_time < self.config.CACHE_EXPIRY

    def get(self, file_path: str) -> Optional[str]:
        """Get the classpath from cache if available and valid."""
        cache = self.load()
        cache_key = self.get_key(file_path)
        cache_entry = cache.get(cache_key)

        if cache_entry and self.is_valid(cache_entry):
            return cache_entry['classpath']
        return None

    def set(self, file_path: str, classpath: str) -> None:
        """Cache the classpath for the given file."""
        cache = self.load()
        cache_key = self.get_key(file_path)
        cache[cache_key] = {
            'classpath': classpath,
            'timestamp': time.time()
        }
        self.save(cache)

    def invalidate(self, file_path: str) -> None:
        """Invalidate the cache entry for the given file."""
        cache = self.load()
        cache_key = self.get_key(file_path)
        if cache_key in cache:
            del cache[cache_key]
            self.save(cache)


class ProjectInfo:
    """Handles project-related information and operations."""

    @staticmethod
    def get_root(file_path: str) -> str:
        """Get the project root directory (parent of .git directory)."""
        current_dir = os.path.dirname(os.path.abspath(file_path))
        while current_dir != '/':
            if os.path.exists(os.path.join(current_dir, '.git')):
                return current_dir
            current_dir = os.path.dirname(current_dir)
        raise ValueError("Could not find .git directory")

    @staticmethod
    def is_test_file(file_path: str) -> bool:
        """Check if the file is a test file."""
        return '/src/test/java/' in file_path

    @staticmethod
    def get_module_name(project_root: str) -> str:
        """Get the module name from the project root directory name."""
        return os.path.basename(project_root)


class BuildSystem:
    """Handles build system-specific operations."""

    def __init__(self, config: Config):
        self.config = config

    def get_maven_classpath(self, project_root: str) -> Optional[str]:
        """Get the Maven classpath for the project."""
        try:
            cmd = ['mvn', 'dependency:build-classpath']
            result = subprocess.run(cmd,
                                    cwd=project_root,
                                    capture_output=True,
                                    text=True)
            if result.returncode != 0:
                logger.error("Failed to retrieve maven classpath")
                return None

            match = re.search(self.config.MAVEN_CLASSPATH_PATTERN,
                              result.stdout)
            return match.group(1) if match else None
        except Exception as e:
            logger.error(f"Error getting Maven classpath: {e}")
            return None

    def get_bazel_classpath(self,
                            project_root: str,
                            module: str,
                            is_test: bool) -> Optional[str]:
        """Get the Bazel classpath for the project."""
        try:
            bazel_bin = self._get_bazel_bin(project_root)
            if not bazel_bin:
                return None

            target = f"{module}-tests" if is_test else module
            lib_jar_file = os.path.join(bazel_bin, module, f"lib{target}.jar")

            if (not os.path.exists(lib_jar_file) or
                    os.path.getsize(lib_jar_file) <= 0):
                logger.error(f"Module jar file not found: {lib_jar_file}")
                return None

            deps = self._get_bazel_deps(project_root, module, target)
            if not deps:
                return None

            return ':'.join([lib_jar_file] + deps)
        except Exception as e:
            logger.error(f"Error getting Bazel classpath: {e}")
            return None

    def _get_bazel_bin(self, project_root: str) -> Optional[str]:
        """Get the bazel-bin directory path."""
        result = subprocess.run(['bazel', 'info', 'bazel-bin'],
                                cwd=project_root,
                                capture_output=True,
                                text=True)
        if result.returncode != 0:
            logger.error("Failed to lookup bazel-bin directory")
            return None
        return result.stdout.strip()

    def _get_bazel_deps(self,
                        project_root: str,
                        module: str,
                        target: str) -> Optional[List[str]]:
        """Get Bazel dependencies for the given target."""
        query = ('bazel aquery \'mnemonic("Javac", //{module}:{target})\' '
                 '--output textproto')
        result = subprocess.run(query, shell=True, cwd=project_root,
                                capture_output=True, text=True)
        if result.returncode != 0:
            logger.error("Failed to parse bazel dependencies")
            return None

        deps = []
        for line in result.stdout.split('\n'):
            if 'exec_path:' in line and '.jar' in line:
                jar_path = re.search(self.config.BAZEL_JAR_PATTERN, line)
                if jar_path:
                    deps.append(os.path.join(project_root, jar_path.group(0)))
        return deps


class JavaCompiler:
    """Main compiler class that orchestrates the compilation process."""

    def __init__(self, config: Config):
        self.config = config
        self.cache = CacheManager(config)
        self.build_system = BuildSystem(config)

    def get_classpath(self, file_path: str) -> Optional[str]:
        """Get the classpath for the given Java file."""
        # Try to get from cache first
        cached_cp = self.cache.get(file_path)
        if cached_cp:
            return cached_cp

        try:
            proj_root = ProjectInfo.get_root(file_path)
            is_test = ProjectInfo.is_test_file(file_path)
            module = ProjectInfo.get_module_name(proj_root)

            # Try Maven first
            maven_cp = self.build_system.get_maven_classpath(proj_root)
            if maven_cp:
                target_classes = os.path.join(proj_root, "target", "classes")
                vim_target = os.path.join(proj_root,
                                          self.config.VIM_TARGET_DIR)
                classpath = ':'.join(
                        filter(None, [vim_target, target_classes, maven_cp]))
                self.cache.set(file_path, classpath)
                return classpath

            # Try Bazel if Maven fails
            bazel_cp = self.build_system.get_bazel_classpath(
                proj_root, module, is_test)
            if bazel_cp:
                self.cache.set(file_path, bazel_cp)
                return bazel_cp

            return None
        except Exception as e:
            logger.error(f"Error getting classpath: {e}")
            return None

    def compile(self, java_file: str, javac_args: List[str]) -> int:
        """Compile the given Java file."""
        classpath = self.get_classpath(java_file)

        if not classpath:
            logger.error("Failed to determine classpath")
            return 1

        # Prepare javac command
        target_directory = os.path.join(ProjectInfo.get_root(java_file),
                                        self.config.VIM_TARGET_DIR)
        cmd = [
            'javac',
            '-Xlint',
            '-Xlint:-path',
            '-d', target_directory,
            '-cp', classpath
        ]
        cmd.extend(javac_args)

        # Run javac
        result = subprocess.run(cmd)
        return result.returncode


def main():
    config = Config()
    parser = argparse.ArgumentParser(
            description='Java compiler with classpath caching')
    parser.add_argument('java_file', help='The Java file to compile')
    parser.add_argument(
            '--invalidate-cache',
            action='store_true',
            help='Force a fresh classpath lookup by invalidating the cache')
    parser.add_argument('javac_args', nargs=argparse.REMAINDER,
                        help='Additional arguments to pass to javac')

    args = parser.parse_args()

    compiler = JavaCompiler(config)

    if args.invalidate_cache:
        compiler.cache.invalidate(args.java_file)

    sys.exit(compiler.compile(args.java_file, args.javac_args))


if __name__ == '__main__':
    main()
