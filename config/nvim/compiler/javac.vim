function! s:project_root()
    return fnamemodify(fugitive#extract_git_dir(expand("%:p")), ":h")
endfunction

function! s:with_project_root(dir)
    let sep = (!empty(a:dir) && a:dir[0] ==# '/') ? '' : '/'
    return s:project_root() . sep . a:dir
endfunction

function! s:destination_directory()
    return s:project_root() . "/vim_target"
endfunction

function! s:get_classpath()
    let target_classes = s:project_root() . "/target/classes"
    let build_classpath = s:get_maven_classpath()
    let classpaths = [s:destination_directory(), target_classes, build_classpath]
    return join(filter(classpaths, '!empty(v:val)'), ":")
endfunction

" maven
function! s:get_maven_classpath()
    let classpath_cmd = printf("cd %s && mvn dependency:build-classpath", shellescape(s:project_root()))
    let classpath_pattern = 'classpath:\n\zs[^[].\{-\}\ze\n'
    let maven_output = system(classpath_cmd)
    if v:shell_error != 0
        call dotfiles#utils#echo_error('Failed to retrieve maven classpath')
        return ""
    endif

    return matchstr(maven_output, classpath_pattern)
endfunction

" bazel
function! s:get_bazel_classpath()
    let bazel_bin = s:exec_at_project_root('bazel info bazel-bin 2>/dev/null')[-1]
    if v:shell_error != 0
        call dotfiles#utils#echo_error('Failed to lookup bazel-bin directory')
        return ""
    endif

    let module = s:bazel_module_name()
    let lib_jar_file = printf("%s/%s/lib%s.jar", bazel_bin, module, module)
    if getfsize(lib_jar_file) <= 0
        call dotfiles#utils#echo_error('Module jar file not found: ' . lib_jar_file)
        return ""
    endif

    let bazel_deps = s:get_bazel_deps(module)
    if v:shell_error != 0
        call dotfiles#utils#echo_error('Failed to parse bazel dependencies')
        return ""
    endif
    return lib_jar_file . ':' . join(bazel_deps, ':')
endfunction

function! s:bazel_module_name()
    return fnamemodify(s:project_root(), ":t")
endfunction

function! s:get_bazel_deps(module)
    let bazel_deps_cmd = printf('bazel aquery ''mnemonic("Javac", //%s)'' --output textproto | grep "exec_path:.*\.jar"', a:module)
    let bazel_deps_output = s:exec_at_project_root(bazel_deps_cmd)
    return map(bazel_deps_output, 's:sanitize_bazel_exec_path(v:val)')
endfunction

function! s:exec_at_project_root(cmd)
    let modified_cmd = printf('cd %s >/dev/null 2>&1 && %s', s:project_root(), a:cmd)
    return systemlist(modified_cmd)
endfunction

function! s:sanitize_bazel_exec_path(bazel_exec_path)
    return s:with_project_root(matchstr(a:bazel_exec_path, 'bazel-out.*\.jar'))
endfunction

if exists("current_compiler")
    finish
endif
let current_compiler = "javac"

if !exists("b:cached_javac_classpath")
    let b:cached_javac_classpath = s:get_classpath()
endif
command! -buffer -nargs=0 ResetJavac unlet! b:cached_javac_classpath

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

let $CLASSPATH = b:cached_javac_classpath
let javac_args = ['javac', '-Xlint', '-Xlint:-path', '-d', s:destination_directory(), '%']
execute 'CompilerSet makeprg=' . join(javac_args, '\ ')
CompilerSet errorformat=
        \%E%f:%l:\ error:\ %m,
        \%W%f:%l:\ warning:\ %m,
        \%A%f:%l:\ %m,
        \%-C%p^,
        \%+C\ \ symbol:\ %.%#,
        \%+Z\ \ location:\ %.%#,
        \%-C%.%#,
        \%-G%.%#
