let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("lein repl", "lein")<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
