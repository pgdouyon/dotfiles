let s:save_cpo = &cpoptions
set cpoptions&vim

function! dotfiles#utils#echo_error(message)
    echohl Error | echom a:message | echohl None
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
