let s:save_cpo = &cpoptions
set cpoptions&vim

" markdown headings
nnoremap <buffer> <Leader>h1 <Esc>yypVr=A
nnoremap <buffer> <Leader>h2 <Esc>yypVr-A
nnoremap <buffer> <Leader>h3 <Esc>I### <End>
nnoremap <buffer> <Leader>h4 <Esc>I#### <End>
nnoremap <buffer> <Leader>h5 <Esc>I##### <End>

let &cpoptions = s:save_cpo
unlet s:save_cpo
