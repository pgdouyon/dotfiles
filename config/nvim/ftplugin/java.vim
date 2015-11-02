let s:save_cpo = &cpoptions
set cpoptions&vim

let g:java_highlight_all = 1

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("groovysh", "groovysh")<CR>

" struts
nnoremap <silent><buffer> S :Ag --xml "\b<C-R><C-W>\b"<CR>

nnoremap <silent><buffer> gm :<C-U>call <SID>jump_to_function()<CR>

function! s:jump_to_function()
    let modifiers = '\%(\%(public\|private\|protected\|static\|final\|abstract\|synchronized\|volatile\)\_s\+\)*'
    let generic_types = '\%(<[^({=:.>]\+>\_s\+\)\?'
    let return_val = '[^({=:.]\+\_s\+'
    let function_name = escape(expand("<cword>"), '\')
    let function_start = '^\s*\zs'.modifiers.generic_types.return_val
    call search(function_start.'\V\<'.function_name.'\>\_s\*(', 'sw')
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
