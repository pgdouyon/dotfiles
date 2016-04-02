function! diff#diffget()
    if &diff
        execute s:range() 'diffget'
        call s:next_change()
    endif
endfunction

function! diff#diffput()
    if &diff
        execute s:range() 'diffput'
        call s:next_change()
    endif
endfunction

function! s:range()
    if (v:count == 0)
        return ''
    endif
    return printf('.,.+%d', v:count - 1)
endfunction

function! s:next_change()
    let line = line(".")
    normal! ]c
    if line(".") == line
        normal! 10000[c
    endif
endfunction
