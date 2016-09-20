let s:save_cpo = &cpoptions
set cpoptions&vim

runtime! ftplugin/html.vim
runtime! ftplugin/html/sparkup.vim

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=<#--%s-->
setlocal iskeyword+=-
setlocal define=^\\s*<#assign

let &cpoptions = s:save_cpo
unlet s:save_cpo
