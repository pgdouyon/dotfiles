function! s:get_project_root()
    return fnamemodify(fugitive#extract_git_dir(expand("%:p")), ":h")
endfunction

function! s:get_vim_javac_target()
    return s:get_project_root() . "/vim_target"
endfunction

function! s:get_classpath()
    let project_root = s:get_project_root()
    let classpath_cmd = printf("cd %s && mvn dependency:build-classpath", shellescape(project_root))
    let classpath_pattern = 'classpath:\n\zs[^[].\{-\}\ze\n'
    let maven_output = system(classpath_cmd)
    let maven_classes = project_root . "/target/classes:"
    let vim_target_classes = s:get_vim_javac_target()
    let classpath = vim_target_classes . maven_classes . matchstr(maven_output, classpath_pattern)
    return classpath
endfunction

let current_compiler = "javac"

if !exists("b:cached_javac_classpath")
    let b:cached_javac_classpath = s:get_classpath()
endif
command! -buffer -nargs=0 ResetJavac unlet! b:cached_javac_classpath

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

let $CLASSPATH = b:cached_javac_classpath
let $VIM_JAVAC_TARGET = s:get_vim_javac_target()
CompilerSet makeprg=javac\ -Xlint\ -Xlint:-path\ -d\ $VIM_JAVAC_TARGET\ %
CompilerSet errorformat=
        \%E%f:%l:\ error:\ %m,
        \%W%f:%l:\ warning:\ %m,
        \%A%f:%l:\ %m,
        \%-C%p^,
        \%+C\ \ symbol:\ %.%#,
        \%+Z\ \ location:\ %.%#,
        \%-C%.%#,
        \%-G%.%#
