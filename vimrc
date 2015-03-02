" ======================================================================
" Vim-Plug Bundles
" ======================================================================

call plug#begin('~/.vim/bundle')

" Personal Plugins
Plug 'pgdouyon/vim-niffler'
Plug 'pgdouyon/vim-apparate'
Plug 'pgdouyon/vim-evanesco'
Plug 'pgdouyon/vim-protean'

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
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Editing Enhancements
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}

" Text Objects
Plug 'michaeljsmith/vim-indent-object'

" Appearance
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'jeetsukumaran/vim-filebeagle'

" Tool Integration
Plug 'mhinz/vim-signify'
Plug 'rizzatti/dash.vim', {'on': ['Dash', '<Plug>DashSearch']}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

" Clojure
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-leiningen', {'for': 'clojure'}
Plug 'tpope/vim-classpath', {'for': ['clojure', 'scala']}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}

" Scala
Plug 'derekwyatt/vim-scala'

" JavaScript
Plug 'jelera/vim-javascript-syntax'
Plug 'moll/vim-node'
Plug 'elzr/vim-json'

" HTML
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim', {'for': ['html', 'xml']}
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml']}

" CSS
Plug 'ap/vim-css-color', {'for': 'css'}

" Markdown
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tpope/vim-markdown'

" FreeMarker
Plug 'chaquotay/ftl-vim-syntax'

call plug#end()


" ======================================================================
" Options
" ======================================================================

filetype plugin indent on
syntax enable

" Leader
let mapleader="\<Space>"
let maplocalleader="\<CR>"

" Searching
set incsearch
set ignorecase
set smartcase

" Tags
set tags=./tags;/

" Displaying text
set nowrap
set linebreak
set lazyredraw
set lines=999
set columns=999
set scrolloff=8
set sidescrolloff=5
set conceallevel=2
set display+=lastline

" Syntax/Highlighting
set synmaxcol=500
set cursorline

" Multiple Windows
set laststatus=2
set statusline=%!statusline#schmexy_statusline()
set hidden
set splitbelow
set splitright

" Multiple Tab Pages
set showtabline=2
set tabline=%!statusline#schmexy_tabline()

" Terminal
set ttyfast

" Mouse
set mouse=""

" GUI
set guioptions="cegmt"
silent! set fullscreen

" Messages
set shortmess+=A
set ruler

" Selecting Text
set clipboard=unnamed

" Editing Text
set showmatch
set backspace=indent,eol,start
set formatoptions=tcroq2lj
set complete=.,w,b,t
set nrformats-=octal
set matchpairs+=<:>

" Tabs/Indenting
set autoindent
set smarttab
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=4

" Folding
set foldopen=insert,jump,mark,percent,quickfix,search,tag,undo
set foldtext=foldtext#schmexy_foldtext()

" Diff Mode
set diffopt=filler,vertical

" Mapping
set ttimeout
set ttimeoutlen=50

" Reading/Writing Files
set autowrite
set autoread

" Swap Files
set noswapfile
set directory^=~/.vim/_temp//

" Command Line Editing
set wildmenu
set wildignorecase
set wildmode=list:longest,full
set wildignore+=*.o,*.out,*.obj,.exe,.git,*.pyc,*.rbc,*.rbo,*.gem,*/node_modules/*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar
set wildignore+=**/tmp/*,*.swp,*~
set wildignore+=*.doc*,*.ppt*,*.jpg,*.png,*.pdf
set cedit=<C-C>

" Executing External Commands
set shellslash
set noshelltemp
if has("unix")
    set shell=bash
    let $BASH_ENV = "~/.bashrc"     " expand shell aliases/functions in vim
endif

" Various
set gdefault
set sessionoptions-=options


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

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

nnoremap <silent> <Leader>r :redraw!<Esc>

" faster scrolling
nnoremap <C-E> 3<C-E>
nnoremap <C-Y> 3<C-Y>

" fix {,} motions in files with trailing whitespace
nnoremap <silent> { :call search('^\s*$', 'bW')<CR>
nnoremap <silent> } :call search('^\s*$', 'W')<CR>
onoremap <silent> { :call search('^\s*$', 'bW')<CR>
onoremap <silent> } :call search('^\s*$', 'W')<CR>
xnoremap <silent> { :<C-U>execute "normal! gv" <Bar> call search('^\s*$', 'bW')<CR>
xnoremap <silent> } :<C-U>execute "normal! gv" <Bar> call search('^\s*$', 'W')<CR>

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

" reuse flags when repeating substitute command with &
nnoremap & :&&<CR>

" ----------------------------------------------------------------------
" Window Navigation
" ----------------------------------------------------------------------
nnoremap gw <C-w>
nnoremap <silent> <Left> :vertical resize -5<CR>
nnoremap <silent> <Right> :vertical resize +5<CR>
nnoremap <silent> <Down> :resize -5<CR>
nnoremap <silent> <Up> :resize +5<CR>

" ----------------------------------------------------------------------
" Tags/Definition Search
" ----------------------------------------------------------------------
nnoremap g] g<C-]>
nnoremap g<C-]> g]

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
        colorscheme seoul256-light
    else
        colorscheme seoul256
    endif
endfunction

" ----------------------------------------------------------------------
" ColorColumnToggle
" ----------------------------------------------------------------------
function! s:ColorColumnToggle()
    let w:enableColorcolumn = !get(w:, "enableColorcolumn", 0)
    call s:SetColorColumn()
endfunction

" ----------------------------------------------------------------------
" Scratch Buffer
" ----------------------------------------------------------------------
function! s:Scratch()
    let bufname = "__Scratch__"
    execute (buflisted(bufname) ? "buffer " : "edit ") . bufname
    if empty(&filetype)
        set filetype=pandoc
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        setlocal buflisted
    endif
endfunction

nnoremap zs :call <SID>Scratch()<CR>
command! -nargs=1 -complete=dir -bang Keep setlocal buftype= | saveas<bang> <args>

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
            execute bufname("%") ==# bufname("#") ? "wincmd q" : "buffer #"
        endwhile
    endfor
    execute "tabnext " . orig_tab
    execute orig_win . "wincmd w"
    execute "bdelete " . buf_to_kill
endfunction

nnoremap <silent> <Leader>bd :call <SID>BufKill()<CR>

" ----------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------
function! s:TodoList(include_tag, search_dir)
    let todo_dir = a:search_dir
    if empty(todo_dir)
        let git_dir = finddir(".git", expand("%:p:h").";".expand("$HOME"))
        let svn_dir = finddir(".svn", expand("%:p:h").";".expand("$HOME"))
        let hg_dir = finddir(".hg", expand("%:p:h").";".expand("$HOME"))
        let default_dir = expand("%:p")
        for dir in [git_dir, svn_dir, hg_dir, default_dir]
            if !empty(dir)
                let vcs_dir = dir
                break
            endif
        endfor
        let todo_dir = fnamemodify(vcs_dir, ":h")
    endif

    let todo_tag = escape(g:todo_tag, '()[]{}<>!@#$%^&*-_+=\|?.')
    let todo = 'TODO\|FIXME\|XXX'
    let todo_tagged = join(map(split(todo, '\\|'), "v:val.' '.'".todo_tag."'"), '\|')
    let todo_str = a:include_tag ? todo_tagged : todo
    execute printf("LAg '%s' %s", todo_str, todo_dir)
endfunction

let g:todo_tag = "[PGD]"
command! -nargs=? -bang -complete=dir TodoList call <SID>TodoList(<bang>1, <q-args>)

nnoremap <Leader>td O<Esc>ccTODO <C-R>=g:todo_tag<CR> <Esc>:normal gcc<CR>==A
nnoremap <Leader>fm O<Esc>ccFIXME <C-R>=g:todo_tag<CR> <Esc>:normal gcc<CR>==A
nnoremap <Leader>xx O<Esc>ccXXX <C-R>=g:todo_tag<CR> <Esc>:normal gcc<CR>==A

" ----------------------------------------------------------------------
" Toggle Trailing Whitespace
" ----------------------------------------------------------------------
function! s:ToggleTrailingWhitespace()
    let w:enableTrailingWhitespace = !get(w:, "enableTrailingWhitespace", 0)
    call s:SetTrailingWhitespace()
endfunction

nnoremap <silent> cot :call <SID>ToggleTrailingWhitespace()<CR>

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
let g:niffler_ignore_extensions = [".class", ".backup"]
let g:niffler_ignore_dirs = ["Library", "Applications", "Downloads", "1Password"]

nnoremap <silent> znf :Niffler<CR>
nnoremap <silent> znh :Niffler %:h<CR>
nnoremap <silent> zng :Niffler -vcs<CR>
nnoremap <silent> znn :Niffler -new<CR>
nnoremap <silent> znN :Niffler -vcs -new<CR>
nnoremap <silent> znm :NifflerMRU<CR>
nnoremap <silent> znb :NifflerBuffer<CR>
nnoremap <silent> znT :NifflerTags<CR>
nnoremap <silent> znt :NifflerTags %<CR>

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

" ----------------------------------------------------------------------
" Unimpaired Settings
" ----------------------------------------------------------------------
function! s:UnimpairedMappings()
    nnoremap <silent> cob :call <SID>ColorToggle()<CR>
    nnoremap <silent> cou :call <SID>ColorColumnToggle()<CR>
endfunction

" ----------------------------------------------------------------------
" Vim-Easy-Align
" ----------------------------------------------------------------------
nmap <Leader>a <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

" ----------------------------------------------------------------------
" FileBeagle
" ----------------------------------------------------------------------
function! s:FileBeagleHome()
    normal q
    execute "FileBeagle " . expand("~")
endfunction

augroup FileBeagle
    autocmd BufEnter *filebeagle* nnoremap <silent><buffer><nowait> ~ :<C-U>call <SID>FileBeagleHome()<CR>
augroup END

" ----------------------------------------------------------------------
" Emmet
" ----------------------------------------------------------------------
let g:user_emmet_leader_key='<C-P>'
let g:user_emmet_mode = 'nvi'

" ----------------------------------------------------------------------
" Pandoc Syntax
" ----------------------------------------------------------------------
let g:pandoc#syntax#conceal#blacklist = ['ellipses']

" ----------------------------------------------------------------------
" Vim-Markdown
" ----------------------------------------------------------------------
let g:markdown_fenced_languages = ['vim', 'python', 'clojure', 'javascript']

" ----------------------------------------------------------------------
" Dash
" ----------------------------------------------------------------------
nmap K <Plug>DashSearch

" ----------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------
nnoremap <F10> :TagbarToggle<CR>

" ----------------------------------------------------------------------
" Seoul256
" ----------------------------------------------------------------------
let g:seoul256_background=236
let g:seoul256_light_background=255

" ----------------------------------------------------------------------
" Endwise
" ----------------------------------------------------------------------
let g:endwise_no_mappings = 1
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
    autocmd BufRead,BufNewFile *.ftl set filetype=ftl
    autocmd ColorScheme * call s:SetupColorScheme()
    autocmd Filetype pandoc,markdown setlocal spell
    autocmd SourceCmd *unimpaired.vim source <afile> | call <SID>UnimpairedMappings()
augroup END

" ----------------------------------------------------------------------
" Colorscheme Settings
" ----------------------------------------------------------------------
function! s:SetupColorScheme()
    highlight clear TrailingWhitespace
    highlight link TrailingWhitespace Error
    if &background == "dark"
        highlight DiffChange ctermbg=25 guibg=#005faf
    endif
endfunction

function! s:SetColorColumn()
    if !exists("w:enableColorcolumn")
        let w:enableColorcolumn = 1
    endif
    if w:enableColorcolumn
        silent! call matchadd("ColorColumn", '\%>100v.', 0, 954)
        echohl WarningMsg | echo "ColorColumn enabled..." | echohl None
    else
        silent! call matchdelete(954)
        echohl WarningMsg | echo "ColorColumn disabled..." | echohl None
    endif
endfunction

function! s:SetTrailingWhitespace()
    if !exists("w:enableTrailingWhitespace")
        let w:enableTrailingWhitespace = 1
    endif
    if w:enableTrailingWhitespace
        silent! call matchadd("TrailingWhitespace", '\s\+$', 0, 955)
        echohl WarningMsg | echo "Trailing Whitespace enabled..." | echohl None
    else
        silent! call matchdelete(955)
        echohl WarningMsg | echo "Trailing Whitespace disabled..." | echohl None
    endif
endfunction

" ----------------------------------------------------------------------
" Background Settings
" ----------------------------------------------------------------------
if has('vim_starting')
    colorscheme seoul256
    silent call s:SetColorColumn()
    silent call s:SetTrailingWhitespace()
endif
