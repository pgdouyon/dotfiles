let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent><buffer> K :help <C-R><C-W><CR>

nnoremap <silent><buffer> [m :<C-U>call <SID>move_to_function_start("n", 0)<CR>
nnoremap <silent><buffer> ]m :<C-U>call <SID>move_to_function_start("n", 1)<CR>
xnoremap <silent><buffer> [m :<C-U>call <SID>move_to_function_start("v", 0)<CR>
xnoremap <silent><buffer> ]m :<C-U>call <SID>move_to_function_start("v", 1)<CR>
onoremap <silent><buffer> [m :<C-U>call <SID>move_to_function_start("o", 0)<CR>
onoremap <silent><buffer> ]m :<C-U>call <SID>move_to_function_start("o", 1)<CR>

nnoremap <silent><buffer> [M :<C-U>call <SID>move_to_function_end("n", 0)<CR>
nnoremap <silent><buffer> ]M :<C-U>call <SID>move_to_function_end("n", 1)<CR>
xnoremap <silent><buffer> [M :<C-U>call <SID>move_to_function_end("v", 0)<CR>
xnoremap <silent><buffer> ]M :<C-U>call <SID>move_to_function_end("v", 1)<CR>
onoremap <silent><buffer> [M :<C-U>call <SID>move_to_function_end("o", 0)<CR>
onoremap <silent><buffer> ]M :<C-U>call <SID>move_to_function_end("o", 1)<CR>

nnoremap <silent><buffer> gm :<C-U>call <SID>jump_to_function()<CR>

function! s:move_to_function_start(mode, forward)
    if a:mode ==# "v"
        normal! gv
    elseif a:mode ==# "o"
        normal! V
    endif
    let flags = a:forward ? "sW" : "bsW"
    call search('^\s*\zsfu[nction!]*', flags)
endfunction

function! s:move_to_function_end(mode, forward)
    if a:mode ==# "v"
        normal! gv
    elseif a:mode ==# "o"
        normal! V
    endif
    let flags = a:forward ? "sW" : "bsW"
    call search('^\s*\zsendf[unction]*$', flags)
endfunction

function! s:jump_to_function()
    let [save_isk, &iskeyword] = [&iskeyword, &iskeyword . ",:"]
    let function_name = escape(expand("<cword>"), '\')
    let function_start = '^\s*fu[nction!]*\s\+\(s:\)\?'
    call search(function_start.'\V\<'.function_name.'\>', 'sw')
    let &iskeyword = save_isk
endfunction

augroup vim_ft
    autocmd!
    autocmd Syntax vim syntax keyword vimTodo contained TODO FIXME XXX
    autocmd Syntax vim syntax keyword vimMap tm[ap] tno[remap]
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
