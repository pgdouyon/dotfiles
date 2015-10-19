let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("irb", "irb")<CR>

let g:ruby_no_expensive = 1
let g:ruby_no_comment_fold = 1

setlocal shiftwidth=2
setlocal softtabstop=2

compiler rubocop

augroup ruby
    autocmd!
    autocmd BufWrite <buffer> Accio rubocop
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
