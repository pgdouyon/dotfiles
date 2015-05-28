let s:save_cpo = &cpoptions
set cpoptions&vim

" ======================================================================
" Tabline
" ======================================================================
function! statusline#schmexy_tabline()
    let tabline_list = []
    for tabnr in range(tabpagenr("$"))
        let active_tab = (tabpagenr() == tabnr + 1)
        let tab_hl = (active_tab ? "%#TabLineSel#" : "%#TabLine#")
        let tab_nr = " %".(tabnr + 1)."T".(tabnr + 1)
        let tab_entry = tab_hl.tab_nr.' %{statusline#get_tab_entry('.(tabnr + 1).')} '
        call add(tabline_list, tab_entry)
    endfor
    let tabline = join(tabline_list, "")
    let tabline .= " %#TablineFill#%T%=%#TabLine# tabs "
    return tabline
endfunction


function! statusline#get_tab_entry(tabnr)
    let tab_buflist = tabpagebuflist(a:tabnr)
    let tab_winnr = tabpagewinnr(a:tabnr)
    let bufnr = tab_buflist[tab_winnr - 1]
    let modified = getbufvar(bufnr, "&modified")
    let filetype = getbufvar(bufnr, "&filetype")
    let bufname = (filetype ==# "qf" ? statusline#get_quickfix_text() : bufname(bufnr))
    let bufname_tail = fnamemodify(bufname, ":t")
    let tab_entry = "%" . a:tabnr . "T"
    let tab_entry = (modified ? bufname_tail."+" : bufname_tail)
    return tab_entry
endfunction


" ======================================================================
" Statusline
" ======================================================================
function! statusline#schmexy_statusline()
    let left_status = "%(%{statusline#get_buftype_text()} %f%m%r%)"
    let right_status = "%{&filetype} |%4l:%3v %3p%% "
    let accio_status = exists("*accio#statusline") ? ' %#WarningMsg#%{statusline#get_accio_text()}%*' : ""
    return left_status . accio_status . "  %=  " . right_status
endfunction


function! statusline#get_buftype_text()
    let buftype = (exists("g:loaded_fugitive") ? fugitive#statusline() : "")
    let buftype = (&buftype ==# "help" ? "Help" : buftype)
    let buftype = (&buftype ==# "quickfix" ? statusline#get_quickfix_text() : buftype)
    let buftype = (&previewwindow ? "Preview" : buftype)
    return (empty(buftype) ? "" : buftype)
endfunction


function! statusline#get_quickfix_text()
    let grepprg = matchstr(&grepprg, '^\w*')
    let quickfix_title = (exists("w:quickfix_title") ? w:quickfix_title : "")
    let quickfix_title = substitute(quickfix_title, '\V:'.&grepprg, '', '')
    redir => buffers
    silent ls
    redir END

    let bufnr = bufnr("%")
    for buf in split(buffers, "\n")
        if (buf =~# '^\s*'.bufnr)
            if (buf =~# '\[Quickfix List\]')
                return "Quickfix [".grepprg.quickfix_title."]"
            else
                return "Location [".grepprg.quickfix_title."]"
            endif
        endif
    endfor
    return ""
endfunction


function! statusline#get_accio_text()
    if accio#statusline() !=# "Errors: 0"
        return " " . accio#statusline() . " "
    else
        return ""
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
