let s:save_cpo = &cpoptions
set cpoptions&vim

" ----------------------------------------------------------------------
" Settings
" ----------------------------------------------------------------------
setlocal foldmethod=indent
setlocal foldlevel=999

compiler flake8

" ----------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------
function! s:binary()
    let binaries = filter(["python3", "python2"], 'executable(v:val)')
    return get(binaries, 0, "python")
endfunction

nnoremap <silent><buffer> R :<C-U>call repl#start_repl(<SID>binary(), <SID>binary())<CR>
if empty(mapcheck("K", "n"))
    nnoremap <silent><buffer> K :python help("<C-R><C-W>")<CR>
endif

nnoremap <silent><buffer> gd :<C-U>call <SID>goto_local_declaration()<CR>
nnoremap <silent><buffer> gm :<C-U>call <SID>jump_to_function()<CR>

" ----------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------
function! s:goto_local_declaration()
    let last_position = getpos(".")
    let variable = escape(expand("<cword>"), '\')
    normal [m
    call search('\V\<'.variable.'\>', 'W')
    call setpos("''", last_position)
endfunction

function! s:jump_to_function()
    let function_name = escape(expand("<cword>"), '\')
    let function_start = '^\s*def\s\+'
    call search(function_start.'\V\<'.function_name.'\>', 'sw')
endfunction

function! s:sort_imports()
    let save_cursor = getpos(".")
    call cursor(1, 0)
    let import_start = search('\v^(import|from \S+ import)', 'cW')
    let import_end = search('\v^%(import|from \S+ import)\@!\S', 'W') - 1

    if import_start
        let imports = filter(getline(import_start, import_end), 'v:val =~# ''\v^(import|from \S+ import)''')
        let sorted_imports = uniq(sort(imports, "s:compare_imports"))
        let ordered_imports = []
        for import_regex in b:python_import_order
            let matching_imports = filter(copy(sorted_imports), 'v:val =~# import_regex')
            if !empty(matching_imports)
                call filter(sorted_imports, 'v:val !~# import_regex')
                call extend(ordered_imports, matching_imports)
                call add(ordered_imports, '')
            endif
        endfor
        if getline(import_start, import_end) !=# ordered_imports
            execute "silent" import_start . "," . import_end "delete _"
            call append(import_start - 1, ordered_imports)
        endif
    endif
    call setpos(".", save_cursor)
endfunction

let b:python_import_order = ['import .*', 'from \S\+ import \S\+']

command! -nargs=0 -buffer SortImports call <SID>sort_imports()

augroup python_ftplugin
    autocmd BufWritePre <buffer> SortImports
    autocmd BufWrite <buffer> Accio flake8
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
