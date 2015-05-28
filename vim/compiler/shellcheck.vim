" Vim compiler file
" Compiler:     ShellCheck
" Language:     Shell

let current_compiler = "shellcheck"

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=shellcheck\ -f\ gcc\ %

CompilerSet errorformat=
        \%W%f:%l:%c:\ note:\ %m,
        \%W%f:%l:%c:\ warning:\ %m,
        \%E%f:%l:%c:\ error:\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
