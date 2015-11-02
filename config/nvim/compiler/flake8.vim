" Vim compiler file
" Compiler:     Flake8
" Language:     Python

let current_compiler = "flake8"

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=flake8\ $*\ %

CompilerSet errorformat=%f:%l:%c:\ %t%n\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
