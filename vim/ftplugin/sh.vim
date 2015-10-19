let s:save_cpo = &cpoptions
set cpoptions&vim

augroup shell
    autocmd BufWrite <buffer> Accio shellcheck
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
