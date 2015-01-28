let s:save_cpo = &cpoptions
set cpoptions&vim

" markdown headings
inoremap <buffer> <C-H>1 <Esc>yypVr=A
inoremap <buffer> <C-H>2 <Esc>yypVr-A
inoremap <buffer> <C-H>3 <Esc>I### <End>
inoremap <buffer> <C-H>4 <Esc>I#### <End>
inoremap <buffer> <C-H>5 <Esc>I##### <End>

let &cpoptions = s:save_cpo
unlet s:save_cpo
