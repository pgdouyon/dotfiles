let s:save_cpo = &cpoptions
set cpoptions&vim

if exists(":Man")
    nnoremap <buffer><silent> K :Man <C-R><C-W><CR>
endif

augroup shell
    autocmd BufWrite <buffer> Accio shellcheck
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
