let s:save_cpo = &cpoptions
set cpoptions&vim

function! json#format()
    let start_line = v:lnum
    let end_line = (v:lnum + v:count - 1)
    let lines = join(getline(start_line, end_line), '')
    let formatted_lines = systemlist('jq .', lines)
    if v:shell_error != 0
        echohl Error | echom join(formatted_lines, '; ') | echohl None
        return 0
    elseif !empty(formatted_lines)
        execute printf('%d,%d', start_line, end_line) 'delete'
        call setline(start_line, formatted_lines)
        return 0
    else
        return 1
    endif
endfunction

if executable("jq")
    setlocal formatexpr=json#format()
endif

let &cpoptions = s:save_cpo
unlet s:save_cpo
