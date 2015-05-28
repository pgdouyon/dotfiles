let s:save_cpo = &cpoptions
set cpoptions&vim

augroup nim
    autocmd!
    autocmd BufWrite <buffer> Accio nimcheck
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
