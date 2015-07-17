let s:save_cpo = &cpoptions
set cpoptions&vim

" ----------------------------------------------------------------------
" Settings
" ----------------------------------------------------------------------
setlocal foldmethod=indent
setlocal foldlevel=999

compiler flake8

" ----------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------
nnoremap <silent><buffer> R :<C-U>call repl#start_repl("python", "python")<CR>
nnoremap <silent><buffer> K :python help("<C-R><C-W>")<CR>

nnoremap <silent><buffer> gd :<C-U>call <SID>goto_local_declaration()<CR>
nnoremap <silent><buffer> gm :<C-U>call <SID>jump_to_function()<CR>

" ----------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------
function! s:goto_local_declaration()
    let last_position = getpos(".")
    let variable = escape(expand("<cword>"), '\')
    normal [m
    call search('\V\<'.variable.'\>', 'W')
    call setpos("''", last_position)
endfunction

function! s:jump_to_function()
    let function_name = escape(expand("<cword>"), '\')
    let function_start = '^\s*def\s\+'
    call search(function_start.'\V\<'.function_name.'\>', 'sw')
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo