if exists("current_compiler")
    finish
endif
let current_compiler = "javac"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

" Define script paths
let s:compiler_script = expand('<sfile>:p:h') . '/java_compiler.py'

" Add ResetJavac command to invalidate cache
if exists(":ResetJavac") != 2
    command! -buffer -nargs=0 ResetJavac call <SID>reset_cache()
endif

function! s:reset_cache()
    let cmd = [s:compiler_script, '--invalidate-cache', expand('%:p')]
    call system(cmd)
endfunction

" Use our Python script for compilation
let javac_args = [s:compiler_script, '%']
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
