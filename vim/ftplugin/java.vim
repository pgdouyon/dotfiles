let s:save_cpo = &cpoptions
set cpoptions&vim

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
