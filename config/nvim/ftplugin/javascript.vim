let s:save_cpo = &cpoptions
set cpoptions&vim

setlocal define=^\\s*var

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("node", "node")<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
