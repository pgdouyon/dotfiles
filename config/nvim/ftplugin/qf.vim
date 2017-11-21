let s:save_cpo = &cpoptions
set cpoptions&vim

set nobuflisted

nnoremap <silent><buffer><nowait> <CR> <CR>
nnoremap <silent><buffer><nowait> o <CR><C-W>p
nnoremap <silent><buffer><nowait> <C-s> <C-W><CR><C-W>p<C-W>J<C-W>p
nnoremap <silent><buffer><nowait> <C-v> <C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p
nnoremap <silent><buffer><nowait> <C-t> <C-W><CR><C-W>T
nnoremap <silent><buffer><nowait> q :execute <SID>close_command()<CR>

nnoremap <silent><buffer><nowait> O <CR><C-W>p:execute <SID>close_command()<CR>

function! s:close_command()
    return empty(getloclist(0)) ? 'cclose' : 'lclose'
endfunction

function! s:resize()
    if winheight(0) > 10
        resize 10
    endif
    wincmd J
endfunction

autocmd WinEnter <buffer> call <SID>resize()

let &cpoptions = s:save_cpo
unlet s:save_cpo
