let s:save_cpo = &cpoptions
set cpoptions&vim

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=<#--%s-->
setlocal iskeyword+=-

let &cpoptions = s:save_cpo
unlet s:save_cpo
