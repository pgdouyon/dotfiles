let s:save_cpo = &cpoptions
set cpoptions&vim

let s:repls_to_bufnr = {}

" ======================================================================
" Start Repl
" ======================================================================
function! repl#start_repl(repl, title, ...)
    if has("nvim")
        let filetype = a:0 ? a:1 : &filetype
        let wincmd = (winwidth(0) <= (&columns / 2)) ? "wincmd s" : "wincmd v"
        execute wincmd
        if bufexists(get(s:repls_to_bufnr, a:repl, -1))
            execute 'buffer' s:repls_to_bufnr[a:repl]
        else
            execute "terminal" a:repl
            execute "setlocal filetype=".filetype
            execute "file" a:title
            let s:repls_to_bufnr[a:repl] = bufnr('%')
        endif
    else
        execute "Start! -title=".a:title." ".a:repl
        call system("tmux join-pane -h -p 30 -s ".a:title)
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
