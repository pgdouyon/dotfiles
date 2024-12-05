function! s:project_root()
    return fnamemodify(FugitiveExtractGitDir(expand("%:p")), ":h")
endfunction

function! s:with_project_root(dir)
    let sep = (!empty(a:dir) && a:dir[0] ==# '/') ? '' : '/'
    return s:project_root() . sep . a:dir
endfunction

function! s:file_info()
    let profile = s:is_test_file() ? 'test' : 'main'
    return {'module': s:module_name(), 'profile': profile}
endfunction

function! s:module_name()
    return fnamemodify(s:project_root(), ":t")
endfunction

function! s:classpath_key(file_info)
    return a:file_info.module . '-' . a:file_info.profile
endfunction

function! s:is_test_file()
    return expand("%:p") =~# '.*/src/test/java/.*'
endfunction

function! s:destination_directory()
    return s:project_root() . "/vim_target"
endfunction

function! s:join_classpaths(...)
    return s:join_classpath_list(a:000)
endfunction

function! s:join_classpath_list(classpaths)
    return join(filter(copy(a:classpaths), '!empty(v:val)'), ":")
endfunction

function! s:lookup_classpath()
    let classpath_key = s:classpath_key(s:file_info())
    if empty(get(g:cached_javac_classpaths, classpath_key, ""))
        let g:cached_javac_classpaths[classpath_key] = s:get_classpath()
    endif
    return g:cached_javac_classpaths[classpath_key]
endfunction

function! s:get_classpath()
    try
        let target_classes = s:project_root() . "/target/classes"
        " TODO use file_info.profile to fetch classpath for test files
        let file_info = s:file_info()
        let build_classpath = s:get_maven_classpath(file_info)
        return s:join_classpaths(s:destination_directory(), target_classes, build_classpath)
    catch
        return ""
    endtry
endfunction

" maven
function! s:get_maven_classpath(file_info)
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
function! s:get_bazel_classpath(file_info)
    let bazel_bin = s:exec_at_project_root('bazel info bazel-bin 2>/dev/null')[-1]
    if v:shell_error != 0
        call dotfiles#utils#echo_error('Failed to lookup bazel-bin directory')
        return ""
    endif

    let target = s:get_bazel_target(a:file_info)
    let lib_jar_file = printf("%s/%s/lib%s.jar", bazel_bin, a:file_info.module, target)
    if getfsize(lib_jar_file) <= 0
        call dotfiles#utils#echo_error('Module jar file not found: ' . lib_jar_file)
        return ""
    endif

    let bazel_deps = s:get_bazel_deps(a:file_info.module, target)
    if v:shell_error != 0
        call dotfiles#utils#echo_error('Failed to parse bazel dependencies')
        return ""
    endif
    return s:join_classpaths(lib_jar_file, s:join_classpath_list(bazel_deps))
endfunction

function! s:get_bazel_target(file_info)
    return a:file_info.profile ==# 'test' ? a:file_info.module . '-tests' : a:file_info.module
endfunction

function! s:get_bazel_deps(module, target)
    let bazel_deps_cmd = printf(
                \ 'bazel aquery ''mnemonic("Javac", //%s:%s)'' --output textproto | grep "exec_path:.*\.jar"',
                \ a:module,
                \ a:target)
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

function! s:reset_classpath()
    call remove(g:cg_javac_classpaths, s:classpath_key(s:file_info()))
endfunction

if exists("current_compiler")
    finish
endif
let current_compiler = "javac"

if !exists("g:cached_javac_classpaths")
    let g:cached_javac_classpaths = {}
endif

if exists(":ResetJavac") != 2
    command! -buffer -nargs=0 ResetJavac call <SID>reset_classpath()
endif

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

let $CLASSPATH = s:lookup_classpath()
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
