let s:save_cpo = &cpoptions
set cpoptions&vim

augroup help
    autocmd BufEnter <buffer> if winwidth(0) > (&columns / 2) | wincmd L | endif
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
