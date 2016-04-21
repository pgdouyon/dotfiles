let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent><buffer><nowait> <CR> <CR>
nnoremap <silent><buffer><nowait> s <C-W><CR><C-W>p<C-W>J<C-W>p
nnoremap <silent><buffer><nowait> v <C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p
nnoremap <silent><buffer><nowait> t <C-W><CR><C-W>T
nnoremap <silent><buffer><nowait> q :call <SID>CloseQuickfix()<CR>

function! s:CloseQuickfix()
    redir => buffers
    silent ls
    redir END

    let bufnr = bufnr("%")
    for buf in split(buffers, "\n")
        if (buf =~# '^\s*'.bufnr)
            let close = (buf =~# '\[Quickfix List\]' ? "cclose" : "lclose")
            execute close
            return
        endif
    endfor
endfunction

wincmd J
autocmd BufEnter <buffer> wincmd J

let &cpoptions = s:save_cpo
unlet s:save_cpo
