" ======================================================================
" Vim-Plug Bundles
" ======================================================================

call plug#begin('~/.vim/bundle')

" Shougo
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'

" Tim Pope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'tpope/timl'

" Editing Enhancements (IDE features)
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'
Plug 'kris89/vim-multiple-cursors'

" Text Objects
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'

" Window/Buffer Management
Plug 'pgdouyon/vim-mazda'

" GUI Plugins
Plug 'bling/vim-airline'
Plug 'Lokaltog/powerline-fonts'
Plug 'pgdouyon/vimroom'

" ColorSchemes
Plug 'altercation/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
" Plug 'flazz/vim-colorschemes'

" Tool Integration
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'

" Clojure
Plug 'guns/vim-sexp'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-classpath', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}

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

" Deprecated
" Plug 'matthias-guenther/hammer.vim', {'for': 'markdown'}
" Plug 'godlygeek/tabular'

call plug#end()


" ======================================================================
" Settings
" ======================================================================

set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax on

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
set textwidth=80

set nrformats-=octal    " octal is the devil, don't allow it
set mouse=""            " the mouse is the devil, don't allow it
set shellslash          " use forward slashes for file names
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
set completeopt+=longest
set diffopt="filler,vertical"
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
    set grepprg=ack\ --noheading\ --nocolor\ --column\ --follow\ --smart-case
    set grepformat=%f:%l:%c:%m
endif


" ======================================================================
" Mappings
" ======================================================================

inoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
onoremap <C-j> <Esc>
cnoremap <C-j> <C-c>

" make j and k operate over display lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" simplify inline navigation
nnoremap H ^
nnoremap L $
nnoremap ^ H
nnoremap $ L

" global substitution
nnoremap gs :%s/

" make Y play nice like C and D do
nnoremap Y y$

" yank-paste -> paste the last yank
nnoremap yp "0p
nnoremap yP "0P

" reuse flags when repeating substitute command with &
nnoremap & :&&<CR>

" qq to record, Q to replay
nnoremap Q @q

" highlight last inserted text
nnoremap gV `[v`]

" write file with super user privileges
cnoremap w!! w !sudo tee % > /dev/null<CR>

" allows incsearch highlighting for range commands
" stole from reddit - does anyone use easymotion
cnoremap $t <CR>:t''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``

" Source a line of vimscript
" Good for small changes made to vimrc
nnoremap <Leader>ss yy:<C-r>0<BS><CR>
nnoremap <silent> <Leader>sv :silent source $MYVIMRC \| AirlineRefresh<CR>

" switch to alternate buffer
nnoremap <silent> <Leader>bp :buffer #<CR>

" break undo sequence when deleting a line in insert mode
inoremap <C-U> <C-G>u<C-U>

" insert mode completion
inoremap <C-]> <C-x><C-]>
inoremap <C-K> <C-x><C-K>
inoremap <C-F> <C-x><C-F>

" emacs keybindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

inoremap <C-a> <Home>
inoremap <C-e> <End>

" make current file executable
nnoremap <silent> <Leader>x :w<CR>:!chmod 755 %<CR>:e<CR>

" Window navigation commands
nnoremap gw <C-w>
nnoremap <C-Q> <C-w>q
nnoremap <silent> <Leader>tc :tabc<CR>
nnoremap <silent> <Leader>te :tabe<CR>
nnoremap <silent> <Leader>to :tabo<CR>
nnoremap <silent> <Left> :vertical resize -10<CR>
nnoremap <silent> <Right> :vertical resize +10<CR>
nnoremap <silent> <Down> :resize -10<CR>
nnoremap <silent> <Up> :resize +10<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

nnoremap <silent> <Leader>nu :set number!<CR>

" ----------------------------------------------------------------------
" Markdown Headings
" ----------------------------------------------------------------------
inoremap <M-1> <Esc>yypVr=A
inoremap <M-2> <Esc>yypVr-A
inoremap <M-3> <Esc>I### <End>
inoremap <M-4> <Esc>I#### <End>
inoremap <M-5> <Esc>I##### <End>


" ======================================================================
" Functions
" ======================================================================

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
    normal! 3j^
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

nnoremap <silent> <Leader>tb :call <SID>ColorToggle()<CR>

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

nnoremap <Leader>sc :call <SID>Scratch()<CR>

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
            buffer #
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
    let line = getline(".")
    let col = col(".") - 1
    let bol = strpart(line, 0, col) =~ '^\s*$'
    if bol || (line[col] =~ '\k' && line[col + 1] !~ '\k')
        return a:tab
    else
        return a:complete
    endif
endfunction

inoremap <expr> <Tab> <SID>MegaTab("\<C-n>", "\<Tab>")
inoremap <expr> <S-Tab> <SID>MegaTab("\<C-p>", "\<S-Tab>")

" ----------------------------------------------------------------------
" Next Indent Level
" ----------------------------------------------------------------------
function! s:NextIndent(count, dir)
    let lnum = line(".")
    for _ in range(a:count)
        let indent = indent(lnum)
        while lnum > 1 && lnum < line("$")
            let lnum += a:dir
            let next_indent = indent(lnum)
            let empty = empty(getline(lnum))
            if !empty && next_indent != indent
                break
            endif
        endwhile
    endfor
    execute "normal! " . lnum . "G^"
endfunction

noremap zi gi
noremap gi :<C-u>call <SID>NextIndent(v:count1, 1)<CR>
noremap gI :<C-u>call <SID>NextIndent(v:count1, -1)<CR>


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
" VimShell Settings
" ----------------------------------------------------------------------
let g:vimshell_prompt = '$ '
let g:vimshell_right_prompt = 'strftime("%a %b %d  %H:%M %p")'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_editor_command = 'vim'

autocmd BufEnter *vimshell* nnoremap <silent><buffer> q :bd<CR>
autocmd BufEnter *vimshell* inoremap <silent><buffer> <C-G> <Esc>:bd<CR>

nnoremap <silent> <Leader>vsv :vsp<CR>:VimShell<CR>
nnoremap <silent> <Leader>vst :tabe<CR>:VimShell<CR>
nnoremap <silent> <Leader>js :VimShellInteractive node<CR>
nnoremap <silent> <Leader>py :VimShellInteractive python3.3<CR>
nnoremap <silent> <Leader>fr :VimShellInteractive lein repl<CR>
nnoremap <silent> <Leader>lu :VimShellInteractive lua<CR>
nnoremap <silent> <Leader>ms :VimShellInteractive mit-scheme<CR>
nnoremap <silent> <Leader>vx :VimShellExecute
nnoremap <silent> <Leader>ve :VimShellSendString<CR>
vnoremap <silent> <Leader>ve :VimShellSendString<CR>

" ----------------------------------------------------------------------
" Unite Settings
" ----------------------------------------------------------------------
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_save_clipboard = 1
let g:unite_source_rec_max_cache_files = 2000

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --column --follow --smart-case -t'
    let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --follow --hidden --smart-case -t -g ""'
elseif executable('ack-grep')
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '--line-numbers --noheading --column --follow --smart-case -a'
    let g:unite_source_rec_async_command = 'ack --nocolor --nogroup --smart-case -f --nofilter'
endif


call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <Leader>uf :<C-u>Unite -no-split -buffer-name=files file_mru file file/new<CR>
nnoremap <Leader>ur :<C-u>Unite -no-split -buffer-name=files file_rec/async:~/Projects<CR>
nnoremap <Leader>up :<C-u>Unite -no-split -buffer-name=project_files file_rec/async:!<CR>
nnoremap <Leader>ud :<C-u>Unite -no-split -buffer-name=directory directory:~ directory/new<CR>

nnoremap <Leader>ug :<C-u>Unite -no-split -buffer-name=grep grep:.<CR>
nnoremap <Leader>ub :<C-u>Unite -no-split -buffer-name=buffers buffer<CR>

nnoremap <Leader>uo :<C-u>Unite -no-split -buffer-name=outline outline<CR>
nnoremap <Leader>ps :<C-u>Unite -no-split -buffer-name=processes  process<CR>

augroup unite
    autocmd!
    autocmd FileType unite call <SID>unite_settings()
augroup END

function! s:unite_settings()
    set number
    nnoremap <silent><buffer><expr> s unite#do_action('split')
    nnoremap <silent><buffer><expr> v unite#do_action('vsplit')
    nnoremap <silent><buffer><expr> r unite#do_action('rec/async')
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <C-r> unite#do_action('rec/async')
endfunction

" ----------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------
set runtimepath+=~/.fzf
nnoremap <Leader>fz :FZF -x<CR>

" ----------------------------------------------------------------------
" Vim Sneak Settings
" ----------------------------------------------------------------------
highlight SneakPluginTarget None

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
nnoremap <silent> <Leader>gl :Glog --oneline --decorate --<CR>
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
" Airline Settings
" ----------------------------------------------------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
if has("gui_running")
    set guifont=Ubuntu\ Mono\ 11
else
    let g:airline_right_sep=""
endif

let g:airline_symbols.space="\ua0"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_theme = 'base16'
set fillchars+=stl:\ ,stlnc:\

" ----------------------------------------------------------------------
" Mazda
" ----------------------------------------------------------------------
nmap <Leader>zi <Plug>MazdaZoomIn
vmap <Leader>zi <Plug>MazdaZoomIn
nmap <Leader>zo <Plug>MazdaZoomOut
nmap <Leader>zd <Plug>MazdaDiscard
nmap <Leader>zr <Plug>MazdaReselect

" ----------------------------------------------------------------------
" VimRoom
" ----------------------------------------------------------------------
let g:vimroom_width = 100
nmap <silent> <Leader>vr <Plug>VimroomToggle

" ----------------------------------------------------------------------
" CamelCaseMotion
" ----------------------------------------------------------------------
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw

" ----------------------------------------------------------------------
" Targets.vim
" ----------------------------------------------------------------------
let g:targets_aiAI = 'ai  '
let g:targets_nlNL = 'nl  '


" ======================================================================
" Autocmds
" ======================================================================

augroup vimrc
    autocmd!
    "Jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FocusLost *.{html,css} w
    autocmd BufRead,BufNewFile *.md set filetype=pandoc
    autocmd BufRead,BufNewFile *.handlebars,*.hbs set filetype=html
    "reload AirlineTheme because the tab bar gets effed up
    autocmd ColorScheme * call s:ChangeAirlineTheme()
    " make comments more visible
    autocmd ColorScheme * call s:MakeCommentsProminent()
    autocmd ColorScheme * call s:FixGitGutterSignColumn()
augroup END

function! s:ChangeAirlineTheme()
    if (g:colors_name ==# 'solarized') || (g:colors_name ==# 'hybrid')
        silent! AirlineTheme base16
    elseif g:colors_name ==# 'seoul256'
        silent! AirlineTheme luna
    endif
endfunction

function! s:MakeCommentsProminent()
    if (g:colors_name ==# 'solarized') || (g:colors_name ==# 'hybrid')
        highlight clear Comment
        highlight link Comment Todo
    endif
endfunction

function! s:FixGitGutterSignColumn()
    if (g:colors_name ==# 'solarized') || (g:colors_name ==# 'hybrid')
        redir => hl
        silent highlight LineNr
        redir END

        let guibg = matchstr(hl, '\vguibg\=%(\a+|\#\x+)')
        execute "silent! highlight SignColumn " . guibg
        execute "silent! highlight GitGutterAddDefault " . guibg
        execute "silent! highlight GitGutterChangeDefault " . guibg
        execute "silent! highlight GitGutterDeleteDefault " . guibg
    endif
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
        set background=light
        colorscheme solarized
    else
        set background=dark
        colorscheme hybrid
    endif
endfunction


" change background color based on time of day
if strftime('%H') > 6 && strftime("%H") < 18
    call s:SetBackgroundTheme('light')
else
    call s:SetBackgroundTheme('dark')
endif


" ----------------------------------------------------------------------
" Cheat Sheet
" ----------------------------------------------------------------------
" #Multiple-Cursors
    " - <c-n> -> select next
    " - <c-p> -> undo selection and move to previous
    " - <c-x> -> skip current selection
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
" #Vim-Commentary
    " - gc{motion} -> toggle comments for small inline comments
    " - gcc        -> toggle comments for current line
    " - gC{motion} -> comment region
" #Emmet
    " - <C-y>, -> expand/wrap with css-style abbreviation
    " - <C-y>n -> go to next edit point (N for previous)
    " - <C-y>k -> kill tag in block
    " - <C-y>/ -> toggle comment for tag
    " - <C-y>a -> make anchor from URL
    " - <C-y>A -> make quoted text from URL
    " - <C-y>c -> pretty code formatting
