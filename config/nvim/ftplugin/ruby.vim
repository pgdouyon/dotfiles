let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("pry", "pry", "")<CR>

let g:ruby_no_comment_fold = 1

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal iskeyword+=?

compiler rubocop

augroup ruby
    autocmd BufWrite <buffer> Accio rubocop
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
