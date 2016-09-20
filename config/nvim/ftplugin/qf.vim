let s:save_cpo = &cpoptions
set cpoptions&vim

set nobuflisted

nnoremap <silent><buffer><nowait> <CR> <CR>
nnoremap <silent><buffer><nowait> o <CR><C-W>p
nnoremap <silent><buffer><nowait> s <C-W><CR>
nnoremap <silent><buffer><nowait> v <C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p
nnoremap <silent><buffer><nowait> t <C-W><CR><C-W>T
nnoremap <silent><buffer><nowait> q :execute <SID>close_command()<CR>

nnoremap <silent><buffer><nowait> O :call <SID>with_close("\<lt>CR>")<CR>
nnoremap <silent><buffer><nowait> S :call <SID>with_close('s')<CR>
nnoremap <silent><buffer><nowait> V :call <SID>with_close('v')<CR>
nnoremap <silent><buffer><nowait> T :call <SID>with_close('t')<CR>

function! s:with_close(mapping)
    let close = s:close_command()
    call feedkeys(a:mapping)
    call feedkeys(':'.close."\<CR>", 'nt')
endfunction

function! s:close_command()
    return empty(getloclist(0)) ? 'cclose' : 'lclose'
endfunction

autocmd WinEnter <buffer> resize 10

let &cpoptions = s:save_cpo
unlet s:save_cpo
