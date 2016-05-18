let s:save_cpo = &cpoptions
set cpoptions&vim

let g:java_highlight_all = 1

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("groovysh", "groovysh", "groovy")<CR>

" struts
nnoremap <silent><buffer> S :Ag --xml "\b<C-R><C-W>\b"<CR>

function! s:jump_to_class_decl(direction)
    let flags = a:direction . 'sW'
    call search('\C \<class\> \+\zs', flags)
endfunction

nnoremap <silent><buffer> [[ :call <SID>jump_to_class_decl('b')<CR>
nnoremap <silent><buffer> ]] :call <SID>jump_to_class_decl('')<CR>

function! s:sort_imports()
    let save_cursor = getpos(".")
    call cursor(1, 0)
    let import_start = search("^import", 'cW')
    while import_start
        let import_end = search('^\%(import\)\@!', 'W')
        execute import_start ',' (import_end - 1) 'sort r /.*\ze;/'
        let import_start = search("^import", 'W')
    endwhile
    call setpos(".", save_cursor)
endfunction

command! -nargs=0 -buffer SortImports call <SID>sort_imports()

let &cpoptions = s:save_cpo
unlet s:save_cpo
