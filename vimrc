" ======================================================================
" Vim-Plug Bundles
" ======================================================================

call plug#begin('~/.vim/bundle')

" Personal Plugins
Plug 'pgdouyon/vim-b2k'
Plug 'pgdouyon/vim-niffler'
Plug 'pgdouyon/vim-firebolt'
Plug 'pgdouyon/vim-mazda', {'on': ['<Plug>MazdaZoomIn', '<Plug>MazdaToggle']}
Plug 'pgdouyon/vimroom', {'on': '<Plug>VimroomToggle'}

" Tim Pope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}

" Editing Enhancements
Plug 'kris89/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/tmux-complete.vim'

" Text Objects
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-after-object'

" Statusline Plugins
Plug 'bling/vim-airline'
Plug 'Lokaltog/powerline-fonts'
Plug 'jeetsukumaran/vim-filebeagle'

" ColorSchemes
Plug 'junegunn/seoul256.vim'
Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes'

" Tool Integration
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'gregsexton/gitv', {'on': 'Gitv'}

" Clojure
Plug 'kien/rainbow_parentheses.vim'
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
Plug 'mattn/emmet-vim', {'for': ['html', 'xhtml', 'xml']}

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
set number
set ruler
set title
set lazyredraw
set cursorline
set autowrite       " automatically save before commands like :next and :make
set autoread        " automatically read a file if it's been changed on disk
set hidden          " hide buffers when they are abandoned
set ttimeout
set ttimeoutlen=50

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

set nrformats-=octal    " octal is the devil, don't allow it
set mouse=""            " the mouse is the devil, don't allow it
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

" Window/menu
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list,full  " first complete as much as possible, then show list, then select next match
set complete=.,w,t,i
set completeopt+=longest
set diffopt=filler,vertical
set laststatus=2                " always show status line
set guioptions="cegmt"
set clipboard=unnamedplus       " system clipboard uses unnamed register (don't ask why =unnamed didn't work....)
set display+=lastline           " get rid of those ugly '@' that Vim puts after the last line in the window
" set guitablabel=\[%N\]\ %t\ %M

" Files to ignore
set wildignore+=*.o,*.out,*.obj,.exe,.git,*.pyc,*.rbc,*.rbo,*.gem,*/node_modules/*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar
set wildignore+=**/tmp/*,*.swp,*~
set wildignore+=*.doc*,*.ppt*,*.jpg,*.png,*.pdf

" Swap files
set backupdir^=~/.vim/_backup//     " where to put backup files.
set directory^=~/.vim/_temp//       " where to put swap files.
set shortmess+=A                    " no 'existing swap file found' messages

if executable('ag')
    set grepprg=ag\ --noheading\ --nocolor\ --column\ --follow\ --smart-case\ -t
    set grepformat=%f:%l:%c:%m
elseif executable('ack-grep')
    set grepprg=ack-grep\ --noheading\ --nocolor\ --column\ --follow\ --smart-case
    set grepformat=%f:%l:%c:%m
endif


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
nnoremap <silent> <Leader>sv :silent source $MYVIMRC \| AirlineRefresh<CR>

" change buffer
" nnoremap gb :ls<CR>:buffer<Space>

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
" Section Title
" ----------------------------------------------------------------------
function! s:MakeSectionTitle()
    let l:section_title = getline(".")
    let l:length = strlen(l:section_title)
    let l:offset = 34 - (l:length / 2)
    execute "normal! 070R#\<Esc>0" . l:offset . "lR " . l:section_title . " \<Esc>"
    execute "normal gcc"
endfunction

inoremap <C-t> <Esc>:call <SID>MakeSectionTitle()<CR>A

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
" MegaTab
" ----------------------------------------------------------------------
function! s:MegaTab(complete, tab)
    if pumvisible()
        return a:complete
    endif
    let line = getline(".")
    let col = col(".") - 1
    let bol = strpart(line, 0, col) =~ '^\s*$'
    if bol || line[col - 1] =~ '\s'
        return a:tab
    endif

    let complete = empty(&omnifunc) ? a:complete : "\<C-O>"

    let skip_file_completion = ["clojure"]
    for ft in skip_file_completion
        if &filetype ==? ft
            return "\<C-x>".complete
        endif
    endfor

    let keyword = matchstr(strpart(getline("."), 0, col), '\S*$')
    if match(keyword, '\/') != -1
        return "\<C-x>\<C-f>"
    else
        return "\<C-x>".complete
    endif
endfunction

inoremap <expr> <Tab> <SID>MegaTab("\<C-n>", "\<Tab>")
inoremap <expr> <S-Tab> <SID>MegaTab("\<C-p>", "\<S-Tab>")

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
" Next Indent Level
" ----------------------------------------------------------------------
function! s:NextIndent(count, dir)
    let start = line(".")
    let eof = line("$") + 1
    let lines = (a:dir ==? "/" ? range(start, eof) : range(start, 0, -1))
    let indent = indent(start)
    let counter = a:count
    for lnum in lines
        let line = getline(lnum)
        let empty = empty(line)
        let end_statement = (line =~# '^\s*}') || (line =~# '^\s*end')
        let nextIndent = (indent(lnum) != indent) && !empty && !end_statement
        if nextIndent && counter > 1
            let indent = indent(lnum)
            let counter = counter - 1
        elseif nextIndent
            execute "normal! ".lnum."G^"
            return
        endif
    endfor
endfunction

noremap zi gi
noremap <silent> gi :<C-u>call <SID>NextIndent(v:count1, "/")<CR>
noremap <silent> gI :<C-u>call <SID>NextIndent(v:count1, "?")<CR>

" ----------------------------------------------------------------------
" Skip Indent Object
" ----------------------------------------------------------------------
function! s:SkipIndent(count, dir)
    " count is ignored for now, still need to figure out how that would
    " be intuitively used
    let start = line(".")
    let eof = line("$") + 1
    let indent = indent(start)
    let lines = (a:dir ==? "/" ? range(start, eof) : range(start, 0, -1))
    for lnum in lines
        if indent(lnum) > indent
            let start = lnum
            break
        endif
    endfor

    let lines = (a:dir ==? "/" ? range(start, eof) : range(start, 0, -1))
    for lnum in lines
        if indent(lnum) <= indent
            execute "normal! ".lnum."G^"
            return
        endif
    endfor
endfunction

noremap <silent> gb :<C-u>call <SID>SkipIndent(v:count1, "/")<CR>
noremap <silent> gB :<C-u>call <SID>SkipIndent(v:count1, "?")<CR>


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
nnoremap <silent> <Leader>py :call <SID>StartRepl("python3.4")<CR>
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
    autocmd BufEnter *.{clj,html,js} RainbowParenthesesActivate
    autocmd BufLeave *.{clj,html,js} RainbowParenthesesToggleAll
    autocmd ColorScheme *.{clj,html,js} RainbowParenthesesActivate

    autocmd Syntax clojure,html,javascript RainbowParenthesesLoadBraces
    autocmd Syntax clojure,html,javascript RainbowParenthesesLoadChevrons
    autocmd Syntax clojure,html,javascript RainbowParenthesesLoadRound
    autocmd Syntax clojure,html,javascript RainbowParenthesesLoadSquare
augroup END

" ----------------------------------------------------------------------
" Fireplace Settings
" ----------------------------------------------------------------------
nnoremap <silent> <Leader>fdj yiw:Djump <C-r>0<CR>
nnoremap <silent> <Leader>fds yiw:Dsplit <C-r>0<CR>
nnoremap <silent> <Leader>fe :%Eval<CR>

" ----------------------------------------------------------------------
" GitGutter Settings
" ----------------------------------------------------------------------
let g:gitgutter_map_keys = 0
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap gha <Plug>GitGutterStageHunk
nmap ghr <Plug>GitGutterRevertHunk

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
" Gitv Settings
" ----------------------------------------------------------------------
nnoremap <silent> <Leader>gv :Gitv<CR>
nnoremap <silent> <Leader>gV :Gitv!<CR>

" ----------------------------------------------------------------------
" Surround Settings
" ----------------------------------------------------------------------
let g:surround_no_insert_mappings = 1
imap <C-S> <Plug>Isurround

" ----------------------------------------------------------------------
" Airline Settings
" ----------------------------------------------------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
if has("gui_running")
    set guifont=Ubuntu\ Mono\ 12
else
    let g:airline_right_sep=""
endif

let g:airline_symbols.space="\ua0"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_theme = 'tomorrow'
set fillchars+=stl:\ ,stlnc:\

" ----------------------------------------------------------------------
" Mazda
" ----------------------------------------------------------------------
nmap <Leader>zi <Plug>MazdaZoomIn
vmap <Leader>zi <Plug>MazdaZoomIn
nmap <Leader>zt <Plug>MazdaToggle
vmap <Leader>zt <Plug>MazdaToggle
nmap <Leader>zo <Plug>MazdaZoomOut
nmap <Leader>zd <Plug>MazdaDiscard
nmap <Leader>zr <Plug>MazdaReselect

" ----------------------------------------------------------------------
" VimRoom
" ----------------------------------------------------------------------
let g:vimroom_width = 100
nmap <silent> <Leader>vr <Plug>VimroomToggle

" ----------------------------------------------------------------------
" Targets.vim
" ----------------------------------------------------------------------
let g:targets_aiAI = 'ai  '
let g:targets_nlNL = 'nl  '

" ----------------------------------------------------------------------
" Vim-After-Object
" ----------------------------------------------------------------------
augroup after_object
    autocmd VimEnter * call after_object#enable(['a', 'A'], '=', ':', '-', '#', ' ')
augroup END

" ----------------------------------------------------------------------
" Vim-Easy-Align
" ----------------------------------------------------------------------
nmap <Leader>a <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

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

augroup filebeagle
    autocmd!
    autocmd BufEnter *filebeagle* call <SID>FileBeagleMappings()
augroup END

" ======================================================================
" Autocmds
" ======================================================================

augroup vimrc
    autocmd!
    " Jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FocusLost *.{html,css} w
    autocmd BufRead,BufNewFile *.md set filetype=pandoc
    autocmd BufRead,BufNewFile *.handlebars,*.hbs set filetype=html
    autocmd ColorScheme * call s:SetupColorScheme()
    autocmd Filetype pandoc,markdown call s:SetSnippetSynHL()
    autocmd Filetype pandoc,markdown setlocal spell
    autocmd SourceCmd *unimpaired.vim source <afile> | nnoremap <silent> cob :call <SID>ColorToggle()<CR>
    autocmd SourceCmd *unimpaired.vim source <afile> | nnoremap <silent> cou :call <SID>ColorColumnToggle()<CR>
augroup END

" ----------------------------------------------------------------------
" Colorscheme Settings
" ----------------------------------------------------------------------
function! s:SetupColorScheme()
    silent! AirlineRefresh
    call s:MakeCommentsProminent()
    call s:SetCustomHL()
    if &filetype ==? "pandoc" || &filetype ==? "markdown"
        call s:SetSnippetSynHL()
    endif
endfunction

function! s:MakeCommentsProminent()
    highlight clear Comment
    highlight link Comment Exception
endfunction

function! s:SetCustomHL()
    highlight link Snip Structure
    highlight ExtraWhitespace ctermbg=red guibg=red
    highlight clear ColorColumn
    highlight link ColorColumn Error
    match ExtraWhitespace /\s\+$/
    call s:SetColorColumn()
endfunction

function! s:SetColorColumn()
    if !exists("w:enableColorcolumn")
        let w:enableColorcolumn = 1
    endif
    if w:enableColorcolumn
        silent! call matchadd("ColorColumn", '\%>80v', 100, 954)
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
        let g:seoul256_background=235
        colorscheme seoul256
        set background=dark
    endif
endfunction


" change background color based on time of day
if strftime('%H') > 8 && strftime("%H") < 18
    call s:SetBackgroundTheme('light')
else
    call s:SetBackgroundTheme('dark')
endif


" ----------------------------------------------------------------------
" Cheat Sheet
" ----------------------------------------------------------------------
" #Fireplace
    " - K           -> look up docs for keyword under cursor
    " - [d or ]d    -> show source for keyword under cursor
    " - <C-W>d      -> jump to source for keyword under cursor in split
    " - gf          -> go to file for the namespace under the cursor
    " - <Leader>fdj -> jump to symbol definition
    " - <Leader>fds -> jump to symbol definition in split
    " - cp{motion}  -> eval/print the code indicated by {motion}
    " - cpp         -> eval/print the outermost form at the cursor
    " - cpr         -> eval a require :reload form
    " - c!{motion}  -> eval/replace the code indicated by {motion}
    " - c!!         -> eval/replace the innermost form at the cursor
    " - cm{motion}  -> fully macroexpand the macro indicated by {motion}
    " - cmm         -> fully macroexpand the innermost form at the cursor
    " - c1m{motion} -> macroexpand once the code indicated by {motion}
    " - c1mm        -> macroexpand the innermost form at the cursor once
    " - cqp         -> bring up a prompt for code to eval/print
    " - cqc         -> bring up a command-line-window for code to eval/print
    " - cq{motion}  -> bring up a command-line-window with prepopulated text
    "              -> indicated by {motion}
    " - <C-R>(      -> evaluate the given expression and insert the result
" #Emmet
    " - <C-y>, -> expand/wrap with css-style abbreviation
    " - <C-y>n -> go to next edit point (N for previous)
    " - <C-y>k -> kill tag in block
    " - <C-y>/ -> toggle comment for tag
    " - <C-y>a -> make anchor from URL
    " - <C-y>A -> make quoted text from URL
    " - <C-y>c -> pretty code formatting
