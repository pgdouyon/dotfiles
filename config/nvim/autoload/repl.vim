let s:save_cpo = &cpoptions
set cpoptions&vim

" ======================================================================
" Start Repl
" ======================================================================
function! repl#start_repl(repl, title)
    if has("nvim")
        let filetype = &filetype
        let wincmd = (winwidth(0) <= (&columns / 2)) ? "wincmd s" : "wincmd v"
        execute wincmd
        execute "terminal" a:repl
        execute "setlocal filetype=".filetype
    else
        execute "Start! -title=".a:title." ".a:repl
        call system("tmux join-pane -h -p 30 -s ".a:title)
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo