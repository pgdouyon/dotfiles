function! s:project_root()
    return fnamemodify(fugitive#extract_git_dir(expand("%:p")), ":h")
endfunction

function! s:destination_directory()
    return s:project_root() . "/vim_target"
endfunction

function! s:get_classpath()
    let project_root = s:project_root()
    let classpath_cmd = printf("cd %s && mvn dependency:build-classpath", shellescape(project_root))
    let classpath_pattern = 'classpath:\n\zs[^[].\{-\}\ze\n'
    let maven_output = system(classpath_cmd)
    let maven_classes = project_root . "/target/classes"
    let classpath_list = [s:destination_directory(), maven_classes, matchstr(maven_output, classpath_pattern)]
    return join(classpath_list, ':')
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
