let s:save_cpo = &cpoptions
set cpoptions&vim

let g:java_highlight_all = 1

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("groovysh", "groovysh", "groovy")<CR>

" struts
nnoremap <silent><buffer> S :Ag --xml "\b<C-R><C-W>\b"<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
