let s:save_cpo = &cpoptions
set cpoptions&vim

" ======================================================================
" Start Repl
" ======================================================================
function! repl#start_repl(repl, title)
    execute "Start! -title=".a:title." ".a:repl
    call system("tmux join-pane -h -p 30 -s ".a:title)
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
