let s:save_cpo = &cpoptions
set cpoptions&vim

let g:java_highlight_all = 1

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("groovysh", "groovysh", "groovy")<CR>

" struts
nnoremap <silent><buffer> S :Ag --xml "\b<C-R><C-W>\b"<CR>

function! s:jump_to_class_decl(direction)
    let flags = a:direction . 'sW'
    call search('\C \<class\> \+\zs', flags)
endfunction

nnoremap <silent><buffer> [[ :call <SID>jump_to_class_decl('b')<CR>
nnoremap <silent><buffer> ]] :call <SID>jump_to_class_decl('')<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
