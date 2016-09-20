let s:save_cpo = &cpoptions
set cpoptions&vim

runtime! ftplugin/html.vim
runtime! ftplugin/html/sparkup.vim

let b:match_words = '<\@<=\%(#list\):<\@<=\%(\/#list\)>,' . b:match_words
let b:match_words = '<\@<=\%(#if\):<\@<=\%(#else\):<\@<=\%(\/#if\)>,' . b:match_words

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=<#--%s-->
setlocal iskeyword+=-
setlocal define=^\\s*<#assign

let &cpoptions = s:save_cpo
unlet s:save_cpo
