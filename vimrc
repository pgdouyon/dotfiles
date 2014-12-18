" ======================================================================
" Vim-Plug Bundles
" ======================================================================

call plug#begin('~/.vim/bundle')

" Personal Plugins
Plug 'pgdouyon/vim-niffler'
Plug 'pgdouyon/vim-firebolt'
Plug 'pgdouyon/vim-apparate'

" Tim Pope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}

" Editing Enhancements
Plug 'kris89/vim-multiple-cursors'
Plug 'wellle/tmux-complete.vim'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}

" Text Objects
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/vim-after-object'

" Appearance
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'jeetsukumaran/vim-filebeagle'

" Tool Integration
Plug 'mhinz/vim-signify'
Plug 'scrooloose/syntastic'

" Clojure
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-leiningen', {'for': 'clojure'}
Plug 'tpope/vim-projectionist', {'for': 'clojure'}
Plug 'tpope/vim-classpath', {'for': ['clojure', 'scala']}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}

" Scala
Plug 'derekwyatt/vim-scala', {'for': 'scala'}

" Python
Plug 'klen/python-mode', {'for': 'python'}

" JavaScript
Plug 'jelera/vim-javascript-syntax', {'for': 'javascript'}
Plug 'moll/vim-node', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'elzr/vim-json', {'for': 'json'}

" HTML
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'mattn/emmet-vim', {'for': ['html', 'xml']}
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml']}

" CSS
Plug 'ap/vim-css-color', {'for': 'css'}

" Markdown
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['pandoc', 'markdown', 'tex']}

" LaTeX
" Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}

call plug#end()


" ======================================================================
" Settings
" ======================================================================

set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax enable

let mapleader="\<Space>"
let maplocalleader="\<CR>"

" Buffers
set autowrite       " automatically save before commands like :next and :make
set autoread        " automatically read a file if it's been changed on disk
set hidden          " hide buffers when they are abandoned

" Tab/indent
set autoindent
set expandtab       " use spaces instead of tab characters
set smarttab        " make tab at the beginning of line use shiftwidth, instead of tabstop
set shiftround      " indent to multiple of tabstop value
set softtabstop=4   " number of spaces a <Tab> inserts when expandtab is set
set shiftwidth=4    " number of spaces to use for >> and auto indent
set scrolloff=8     " leave 8 lines visible at the top/bottom of the screen
set sidescrolloff=5 " leave 5 colums visible at the left/right side
set backspace=indent,eol,start
set textwidth=0
set linebreak
set nowrap

" Ctags
set tags=./tags;/

" Shell
set shellslash          " use forward slashes for file names
set noshelltemp         " use pipes instead of temporary files
set ttyfast             " demand better performance when in terminal
if has("unix")
    set shell=bash
endif

" Search
set gdefault        " all substiutions have 'g' flag on by default
set ignorecase      " do case insensitive matching
set smartcase       " do smart case matching
set incsearch       " incremental search
set showmatch       " show matching brackets.

" Display
set nonumber
set ruler
set title
set lazyredraw
set cursorline
set splitbelow
set splitright
set conceallevel=2
set diffopt=filler,vertical
set guioptions="cegmt"
set display+=lastline           " get rid of those ugly '@' that Vim puts after the last line in the window
set showtabline=2               " always show tab line
set tabline=%!SchmexyTabLine()
" set guitablabel=\[%N\]\ %t\ %M
set laststatus=2                " always show status line
set statusline=%!SchmexyStatusLine()

" Completion
set wildmenu
set wildmode=longest,list,full  " first complete as much as possible, then show list, then select next match
set complete=.,w,b,t,i
set completeopt+=longest

" Misc
set clipboard=unnamed
set sessionoptions+=localoptions
set nrformats-=octal    " octal is the devil, don't allow it
set mouse=""            " the mouse is the devil, don't allow it

" Mappings timeout
set ttimeout
set ttimeoutlen=50

" Files to ignore
set wildignore+=*.o,*.out,*.obj,.exe,.git,*.pyc,*.rbc,*.rbo,*.gem,*/node_modules/*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar
set wildignore+=**/tmp/*,*.swp,*~
set wildignore+=*.doc*,*.ppt*,*.jpg,*.png,*.pdf

" Swap files
set backupdir^=~/.vim/_backup//     " where to put backup files.
set directory^=~/.vim/_temp//       " where to put swap files.
set shortmess+=A                    " no 'existing swap file found' messages

function! SchmexyTabLine()
    if tabpagenr("$") == 1
        redir => buffers
        silent ls
        redir END

        let tabline_list = []
        let bufnrs = map(split(buffers, "\n"), 'matchstr(v:val, ''^\s*\zs\d\+'')')
        for nr in bufnrs
            let active_buf = (bufnr("%") ==# nr)
            let tab_hl = (active_buf ? "%#TabLineSel#" : "%#TabLine#")
            let tab_entry = tab_hl.' %{GetBufTabEntry('.nr.')} '
            call add(tabline_list, tab_entry)
        endfor
        let tabline = join(tabline_list, "")
        let tabline .= " %#TabLineFill#%=%#TabLine# buffers "
        return tabline
    else
        let tabline_list = []
        for tabnr in range(tabpagenr("$"))
            let active_tab = (tabpagenr() == tabnr + 1)
            let tab_hl = (active_tab ? "%#TabLineSel#" : "%#TabLine#")
            let tab_nr = " %".(tabnr + 1)."T".(tabnr + 1)
            let tab_entry = tab_hl.tab_nr.' %{GetTabEntry('.(tabnr + 1).')} '
            call add(tabline_list, tab_entry)
        endfor
        let tabline = join(tabline_list, "")
        let tabline .= " %#TablineFill#%T%=%#TabLine# tabs "
        return tabline
    endif
endfunction

function! GetBufTabEntry(nr)
    let modified = getbufvar(a:nr, "&modified")
    let bufname = bufname(a:nr)
    let bufname_tail = fnamemodify(bufname, ":t")
    let tab_entry = (modified ? bufname_tail."+" : bufname_tail)
    return tab_entry
endfunction

function! GetTabEntry(tabnr)
    let tab_buflist = tabpagebuflist(a:tabnr)
    let tab_winnr = tabpagewinnr(a:tabnr)
    let bufname = bufname(tab_buflist[tab_winnr - 1])
    let bufname_tail = fnamemodify(bufname, ":t")
    let modified = getbufvar(bufname, "&modified")
    let tab_entry = "%" . a:tabnr . "T"
    let tab_entry = (modified ? bufname_tail."+" : bufname_tail)
    return tab_entry
endfunction

function! SchmexyStatusLine()
    let left_status = "%(%{GetBuftypeText()} %f%m%r%)"
    let right_status = "%{&filetype} |%4l:%3v %3p%% "
    let syntastic_status = "%#WarningMsg#%{ SyntasticStatuslineFlag() }%*"
    return left_status . syntastic_status . "  %=  " . right_status
endfunction

function! GetBuftypeText()
    let buftype = (exists("g:loaded_fugitive") ? fugitive#statusline() : "")
    let buftype = (&buftype ==# "help" ? "Help" : buftype)
    let buftype = (&buftype ==# "quickfix" ? GetQuickfixText() : buftype)
    let buftype = (&previewwindow ? "Preview" : buftype)
    return (empty(buftype) ? "" : buftype)
endfunction

function! GetQuickfixText()
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


" ======================================================================
" Mappings
" ======================================================================

" make j and k operate over display lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" ----------------------------------------------------------------------
" Normal Mode
" ----------------------------------------------------------------------
" simplify inline navigation
noremap H ^
noremap L $
noremap ^ H
noremap $ L

" qq to record, Q to replay
nnoremap Q @q

" highlight last inserted text
nnoremap gV `[v`]

" Source vimrc
nnoremap <silent> <Leader>sv :silent source $MYVIMRC<CR>

" switch to alternate buffer
nnoremap <silent> <Leader>bp :buffer #<CR>

" make current file executable
nnoremap <silent> <Leader>x :w<CR>:!chmod 755 %<CR>:e<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" ----------------------------------------------------------------------
" Yanking
" ----------------------------------------------------------------------
" make Y play nice like C and D do
nnoremap Y y$

" yank-paste -> paste the last yank
nnoremap yp "0p
nnoremap yP "0P

" ----------------------------------------------------------------------
" Substitution
" ----------------------------------------------------------------------
" global substitution
nnoremap gs :%s/
xnoremap gs :s/

" search/replace
nnoremap <Leader>r :%s/\C\<<C-r><C-w>\>/
xnoremap <Leader>r "vy:%s/\C\<<C-r>v\>/

" reuse flags when repeating substitute command with &
nnoremap & :&&<CR>

" ----------------------------------------------------------------------
" Window Navigation
" ----------------------------------------------------------------------
nnoremap gw <C-w>
nnoremap <Leader>q <C-w>q
nnoremap <silent> <Leader>tc :tabc<CR>
nnoremap <silent> <Leader>te :tabe<CR>
nnoremap <silent> <Leader>to :tabo<CR>
nnoremap <silent> <Left> :vertical resize -5<CR>
nnoremap <silent> <Right> :vertical resize +5<CR>
nnoremap <silent> <Down> :resize -5<CR>
nnoremap <silent> <Up> :resize +5<CR>

" ----------------------------------------------------------------------
" Tags/Definition Search
" ----------------------------------------------------------------------
nnoremap g] g<C-]>
nnoremap g<C-]> g]
" nnoremap [i [<C-I>
" nnoremap ]i ]<C-I>
" nnoremap [<C-I> [i
" nnoremap ]<C-I> ]i

" ----------------------------------------------------------------------
" Insert Mode
" ----------------------------------------------------------------------
" break undo sequence when deleting a line in insert mode
inoremap <C-U> <C-G>u<C-U>

" insert mode completion
inoremap <C-]> <C-X><C-]>
inoremap <C-K> <C-X><C-K>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>

" markdown headings
inoremap <C-H>1 <Esc>yypVr=A
inoremap <C-H>2 <Esc>yypVr-A
inoremap <C-H>3 <Esc>I### <End>
inoremap <C-H>4 <Esc>I#### <End>
inoremap <C-H>5 <Esc>I##### <End>

" emacs keybindings
inoremap <C-a> <Home>
inoremap <C-e> <End>

" autoclose braces
inoremap <expr> <CR> <SID>AutocloseBraces()

function! s:AutocloseBraces()
    let prev_char = getline(".")[col(".") - 2]
    if prev_char ==# "{"
        return "\<CR>}\<Esc>==O"
    else
        call feedkeys("\<CR>", "nt")
        call feedkeys("\<Plug>DiscretionaryEnd", "m")
        return ""
    endif
endfunction

" ----------------------------------------------------------------------
" Command Line
" ----------------------------------------------------------------------
" write file with super user privileges
cabbrev w!! w !sudo tee % > /dev/null

" emacs keybindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>


" ======================================================================
" Functions
" ======================================================================

" ----------------------------------------------------------------------
" Tmux Navigation
" ----------------------------------------------------------------------
function! s:TmuxSwitchWindows(direction)
    let old_win = winnr()
    silent execute "wincmd ".a:direction
    if old_win == winnr()
        if a:direction ==? "h"
            call system("tmux select-pane -L")
        elseif a:direction ==? "j"
            call system("tmux select-pane -D")
        elseif a:direction ==? "k"
            call system("tmux select-pane -U")
        elseif a:direction ==? "l"
            call system("tmux select-pane -R")
        endif
    endif
endfunction

nnoremap <silent> <C-H> :<C-u>call <SID>TmuxSwitchWindows("h")<CR>
nnoremap <silent> <C-J> :<C-u>call <SID>TmuxSwitchWindows("j")<CR>
nnoremap <silent> <C-K> :<C-u>call <SID>TmuxSwitchWindows("k")<CR>
nnoremap <silent> <C-L> :<C-u>call <SID>TmuxSwitchWindows("l")<CR>

" ----------------------------------------------------------------------
" Section Box
" ----------------------------------------------------------------------
function! s:MakeSectionBox(border)
    " remove indentation
    call setline(".", substitute(getline("."), '\v^\s*', '', ''))
    execute "normal! O\<Esc>70a" . a:border
    execute "normal! jo\<Esc>70a" . a:border
    " use vim-commentary mapping
    normal! 2k
    normal 3gcc
    normal! 3jO
    startinsert!
endfunction

inoremap <C-b>= <Esc>:call <SID>MakeSectionBox("=")<CR>
inoremap <C-b>- <Esc>:call <SID>MakeSectionBox("-")<CR>

" ----------------------------------------------------------------------
" Toggle Background Color
" ----------------------------------------------------------------------
function! s:ColorToggle()
    if (&background == 'dark')
        call s:SetBackgroundTheme('light')
    else
        call s:SetBackgroundTheme('dark')
    endif
endfunction

nnoremap <silent> cob :call <SID>ColorToggle()<CR>

" ----------------------------------------------------------------------
" ColorColumnToggle
" ----------------------------------------------------------------------
function! s:ColorColumnToggle()
    let w:enableColorcolumn = !w:enableColorcolumn
    call s:SetColorColumn()
endfunction

" ----------------------------------------------------------------------
" Scratch Buffer
" ----------------------------------------------------------------------
function! s:Scratch()
    let bufname = "__Scratch__"
    if buflisted(bufname)
        execute "buffer " . bufname
    else
        execute "edit " . bufname
    endif
    set filetype=pandoc
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal buflisted
endfunction

nnoremap zs :call <SID>Scratch()<CR>

" ----------------------------------------------------------------------
" BufKill
" ----------------------------------------------------------------------
function! s:BufKill()
    let buf_to_kill = bufname("%")
    let orig_win = winnr()
    let orig_tab = tabpagenr()
    for i in range(tabpagenr("$"))
        execute "tabnext " . (i + 1)
        while bufwinnr(buf_to_kill) != -1
            execute bufwinnr(buf_to_kill) . "wincmd w"
            silent! buffer #
        endwhile
    endfor
    execute "tabnext " . orig_tab
    execute orig_win . "wincmd w"
    execute "bdelete " . buf_to_kill
endfunction

nnoremap <silent> <Leader>bd :call <SID>BufKill()<CR>

" ----------------------------------------------------------------------
" Snippet Syntax Highlighting
" ----------------------------------------------------------------------
function! s:SnippetSyntax(lang)
    let syns = split(globpath(&rtp, "syntax/".a:lang.".vim"), "\n")
    if empty(syns)
        return
    endif
    if exists("b:current_syntax")
        let csyn = b:current_syntax
        unlet b:current_syntax
    endif
    silent! execute printf("syntax include @%s %s", a:lang, syns[0])
    execute printf('syntax region %sSnip matchgroup=Snip start="```%s" end="```" ' .
                    \ 'contains=@%s containedin=ALL', a:lang, a:lang, a:lang)

    if exists("csyn")
        let b:current_syntax = csyn
    endif
endfunction

" ----------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------
function! s:TodoList(include_tag)
    let vcs_dir = finddir(".git", expand("%:p:h").";".expand("$HOME"))
    let dir = fnamemodify(vcs_dir, ":h")
    let todo_tag = escape(g:todo_tag, '()[]{}<>!@#$%^&*-_+=\|?.')
    let todo = "TODO|FIXME|XXX"
    let todo_tagged = join(map(split(todo, '|'), "v:val.' '.'".todo_tag."'"), '|')
    let todo_str = a:include_tag ? todo_tagged : todo
    let ag_args = "--noheading --nobreak --nocolor --follow -s -t"
    let ag =  printf("ag %s '%s' %s 2> /dev/null", ag_args, todo_str, dir)

    let todos = []
    let lines = split(system(ag), '\n')
    for line in lines
        let [fname, lnum, text] = matchlist(line, '\v^([^:]*):([^:]*):(.*)$')[1:3]
        call add(todos, {'filename': fname, 'lnum': lnum, 'text': text})
    endfor
    if !empty(todos)
        call setqflist(todos)
        copen
    endif
endfunction

let g:todo_tag = "<PGD>"
command! -bang TodoList call <SID>TodoList(<bang>1)

nnoremap <Leader>td O<Esc>ccTODO <C-R>=g:todo_tag<CR> <Esc>:normal gcc<CR>==A
nnoremap <Leader>fx O<Esc>ccFIXME <C-R>=g:todo_tag<CR> <Esc>:normal gcc<CR>==A
nnoremap <Leader>xx O<Esc>ccXXX <C-R>=g:todo_tag<CR> <Esc>:normal gcc<CR>==A

" ----------------------------------------------------------------------
" Ag
" ----------------------------------------------------------------------
function! s:Ag(cmd, args)
    let old_grepprg = &grepprg
    let old_grepfmt = &grepformat
    let open_cmd = (a:cmd =~# '^l' ? "lopen" : "copen")
    let grep_args = (empty(a:args) ? "-Q ".expand("<cword>") : a:args)
    let &grepprg = 'ag --noheading --nocolor --nobreak --column --follow --smart-case -t -p ~/.agignore'
    let &grepformat = '%f:%l:%c:%m'
    execute a:cmd grep_args
    execute open_cmd
    let &grepprg = old_grepprg
    let &grepformat = old_grepfmt
endfunction

command! -nargs=* -complete=file Ag call <SID>Ag('grep!', <q-args>)
command! -nargs=* -complete=file AgAdd call <SID>Ag('grepadd!', <q-args>)
command! -nargs=* -complete=file LAg call <SID>Ag('lgrep!', <q-args>)
command! -nargs=* -complete=file LAgAdd call <SID>Ag('lgrepadd!', <q-args>)


" ======================================================================
" Plugins
" ======================================================================

" ----------------------------------------------------------------------
" Matchit
" ----------------------------------------------------------------------
if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim
endif

" ----------------------------------------------------------------------
" Dispatch and Tbone Settings
" ----------------------------------------------------------------------
nnoremap <F8> :Make<CR>
nnoremap <silent> <Leader>tw :Twrite right<CR>
vnoremap <silent> <Leader>tw :Twrite right<CR>
nnoremap <silent> <Leader>js :call <SID>StartRepl("node")<CR>
nnoremap <silent> <Leader>hs :call <SID>StartRepl("ghci")<CR>
nnoremap <silent> <Leader>sc :call <SID>StartRepl("scala")<CR>
nnoremap <silent> <Leader>py :call <SID>StartRepl("python3")<CR>
nnoremap <silent> <Leader>fr :call <SID>StartRepl("lein repl")<CR>
nnoremap <silent> <Leader>lu :call <SID>StartRepl("lua")<CR>
nnoremap <silent> <Leader>ms :call <SID>StartRepl("mit-scheme")<CR>

function! s:StartRepl(repl)
    let title = get(split(a:repl), 0)
    execute "Start! -title=".title." ".a:repl
    call system("tmux join-pane -h -p 30 -s ".title)
endfunction

" ----------------------------------------------------------------------
" Niffler Settings
" ----------------------------------------------------------------------
let g:niffler_ignore_extensions = [".class"]
let g:niffler_ignore_dirs = ["Library"]

nnoremap <silent> znf :Niffler<CR>
nnoremap <silent> zng :Niffler -vcs<CR>
nnoremap <silent> znm :NifflerMRU<CR>
nnoremap <silent> znb :NifflerBuffer<CR>
nnoremap <silent> znN :Niffler -new<CR>
nnoremap <silent> znn :Niffler -vcs -new<CR>

" ----------------------------------------------------------------------
" Netrw Settings
" ----------------------------------------------------------------------
let g:netrw_liststyle=1
let g:netrw_browsex_viewer="gnome-open"

" ----------------------------------------------------------------------
" Rainbow Parentheses Settings
" ----------------------------------------------------------------------
augroup rainbow
    autocmd!
    autocmd FileType clojure,html,javascript RainbowParentheses
augroup END

" ----------------------------------------------------------------------
" Fireplace Settings
" ----------------------------------------------------------------------
nnoremap <silent> <Leader>fdj yiw:Djump <C-r>0<CR>
nnoremap <silent> <Leader>fds yiw:Dsplit <C-r>0<CR>
nnoremap <silent> <Leader>fe :%Eval<CR>

" ----------------------------------------------------------------------
" Python-Mode
" ----------------------------------------------------------------------
let g:pymode_rope_complete_on_dot = 0

" ----------------------------------------------------------------------
" Syntastic Settings
" ----------------------------------------------------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_cursor_column = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" ----------------------------------------------------------------------
" Signify Settings
" ----------------------------------------------------------------------
let g:signify_vcs_list = ['git', 'svn']
omap ic <Plug>(signify-motion-inner-pending)
xmap ic <Plug>(signify-motion-inner-visual)
omap ac <Plug>(signify-motion-outer-pending)
xmap ac <Plug>(signify-motion-outer-visual)
nnoremap <silent> <F5> :SignifyRefresh<CR>

" ----------------------------------------------------------------------
" Fugitive Settings
" ----------------------------------------------------------------------
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :Gvdiff<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>ga :Gwrite<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gp :Git push origin master<CR>
nnoremap <silent> <Leader>gh :Git push heroku master<CR>

" ----------------------------------------------------------------------
" Surround Settings
" ----------------------------------------------------------------------
let g:surround_no_insert_mappings = 1
imap <C-S> <Plug>Isurround

" ----------------------------------------------------------------------
" Unimpaired Settings
" ----------------------------------------------------------------------
function! s:UnimpairedMappings()
    nnoremap <silent> cob :call <SID>ColorToggle()<CR>
    nnoremap <silent> cou :call <SID>ColorColumnToggle()<CR>
endfunction

" ----------------------------------------------------------------------
" Vim-After-Object
" ----------------------------------------------------------------------
augroup after_object
    autocmd!
    autocmd VimEnter * call after_object#enable(['a', 'aa'], '=', '#', ' ')
augroup END

" ----------------------------------------------------------------------
" Vim-Easy-Align
" ----------------------------------------------------------------------
nmap <Leader>a <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

" ----------------------------------------------------------------------
" Vim-Oblique
" ----------------------------------------------------------------------
let g:oblique#incsearch_highlight_all = 1

" ----------------------------------------------------------------------
" FileBeagle
" ----------------------------------------------------------------------
function! s:FileBeagleMappings()
    nnoremap <silent><buffer> d :<C-U>call <SID>FileBeagleDelete()<CR>
    nnoremap <silent><buffer> ; :<C-U>call <SID>FileBeagleCommand()<CR>
    nnoremap <silent><buffer> ! :<C-U>call <SID>FileBeagleShell()<CR>
    nnoremap <silent><buffer> ~ :<C-U>call <SID>FileBeagleHome()<CR>
endfunction

function! s:FileBeagleDelete()
    let file = substitute(getline("."), '^\s*', '', '')
    let dir = matchstr(FileBeagleStatusLineCurrentDirInfo(), '\s*"\zs.*\ze"\s*')
    call system("rm ".dir.file)
    call feedkeys("R", "t")
endfunction

function! s:FileBeagleCommand()
    let file = substitute(getline("."), '^\s*', '', '')
    let dir = matchstr(FileBeagleStatusLineCurrentDirInfo(), '\s*"\zs.*\ze"\s*')
    call feedkeys(": ".dir.file."\<Home>", "nt")
endfunction

function! s:FileBeagleShell()
    let file = substitute(getline("."), '^\s*', '', '')
    let dir = matchstr(FileBeagleStatusLineCurrentDirInfo(), '\s*"\zs.*\ze"\s*')
    call feedkeys(": ".dir.file."\<Home>!", "nt")
endfunction

function! s:FileBeagleHome()
    normal q
    execute "FileBeagle " . expand("~")
endfunction

augroup FileBeagle
    autocmd BufEnter *filebeagle* call <SID>FileBeagleMappings()
augroup END

" ----------------------------------------------------------------------
" Emmet
" ----------------------------------------------------------------------
let g:user_emmet_leader_key='<C-M>'


" ======================================================================
" Autocmds
" ======================================================================

augroup vimrc
    autocmd!
    " Jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FocusLost *.{html,css} write
    autocmd BufRead,BufNewFile *.md set filetype=pandoc
    autocmd BufRead,BufNewFile *.handlebars,*.hbs set filetype=html
    autocmd ColorScheme * call s:SetupColorScheme()
    autocmd Filetype pandoc,markdown call s:SetSnippetSynHL()
    autocmd Filetype pandoc,markdown setlocal spell
    autocmd SourceCmd *unimpaired.vim source <afile> | call <SID>UnimpairedMappings()
augroup END

augroup quickfix
    " open file in a new horizontal split ("s"), vertical split ("v"), or tab page ("t")
    autocmd Filetype qf nnoremap <buffer><silent> s <C-W><CR><C-W>p<C-W>J<C-W>p
    autocmd Filetype qf nnoremap <buffer><silent> v <C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p
    autocmd Filetype qf nnoremap <buffer><silent> t <C-W><CR><C-W>T
    autocmd Filetype qf nnoremap <buffer><silent> q :call <SID>CloseQuickfix()<CR>
augroup END

function! s:CloseQuickfix()
    redir => buffers
    silent ls
    redir END

    let bufnr = bufnr("%")
    for buf in split(buffers, "\n")
        if (buf =~# '^\s*'.bufnr)
            let close = (buf =~# '\[Quickfix List\]' ? "cclose" : "lclose")
            execute close
            return
        endif
    endfor
endfunction

" ----------------------------------------------------------------------
" Colorscheme Settings
" ----------------------------------------------------------------------
function! s:SetupColorScheme()
    call s:MakeCommentsProminent()
    call s:SetCustomHL()
    call s:SetColorColumn()
    if &filetype ==? "pandoc" || &filetype ==? "markdown"
        call s:SetSnippetSynHL()
    endif
endfunction

function! s:MakeCommentsProminent()
    highlight clear Comment
    highlight link Comment Exception
endfunction

function! s:SetCustomHL()
    if (g:colors_name =~# "seoul")
        highlight clear StatusLine
        highlight clear StatusLineNC
        highlight link StatusLine LineNr
        let nc_bg = (&background ==? "light" ? "Gray" : "DarkGray")
        execute "highlight StatusLineNC ctermfg=".nc_bg." guifg=".nc_bg
    endif
    highlight link Snip Structure
    highlight ExtraWhitespace ctermbg=red guibg=red
    highlight clear ColorColumn
    highlight link ColorColumn Error
    match ExtraWhitespace /\s\+$/
endfunction

function! s:SetColorColumn()
    if !exists("w:enableColorcolumn")
        let w:enableColorcolumn = 1
    endif
    if w:enableColorcolumn
        silent! call matchadd("ColorColumn", '\%>80v.', 100, 954)
    else
        silent! call matchdelete(954)
    endif
endfunction

function! s:SetSnippetSynHL()
    let langmap = ["c", "cpp", "java", "go", "haskell", "python", "ruby", "lua", "clojure", "scala", "vim", "javascript"]
    for lang in langmap
        call s:SnippetSyntax(lang)
    endfor
endfunction

" ----------------------------------------------------------------------
" Background Settings
" ----------------------------------------------------------------------
" maximize gvim on open, set terminal to 256 colors
if has("gui_running")
    set lines=999 columns=999
else
    set t_Co=256
    let g:solarized_termcolors=256
endif

function! s:SetBackgroundTheme(theme)
    if (a:theme == 'light')
        let g:seoul256_background=256
        colorscheme seoul256
        set background=light
    else
        let g:seoul256_background=236
        colorscheme seoul256
        set background=dark
    endif
endfunction


" change background color based on time of day
if strftime('%H') > 5 && strftime("%H") < 18
    call s:SetBackgroundTheme('light')
else
    call s:SetBackgroundTheme('dark')
endif
