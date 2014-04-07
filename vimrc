""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle Setup
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    set nocompatible
    set encoding=utf-8
    "I don't know why people always use the ',' key...
    let mapleader="\<Space>"
    filetype off

    let neobundle_installed=1
    let neobundle_script=expand('~/.vim/bundle/neobundle.vim/autoload/neobundle.vim')
    if !filereadable(neobundle_script)
        echo "Installing NeoBundle..."
        echo ""
        call mkdir($HOME . "/.vim/bundle", "p")
        call mkdir($HOME . "/.vim/_backup", "p")
        call mkdir($HOME . "/.vim/_temp", "p")

        let git_installed = executable("git")
        if !git_installed
            echo "Git must be installed to finish setup..."
            finish
        endif

        silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
        let neobundle_installed=0
    endif

    set rtp+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle Bundles
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleFetch 'Shougo/neobundle.vim'

"Shougo - Unite plugins OMFG this stuff is awesome!!!!!!!!!
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':
    \ {'commands' : 'NeoCompleteEnable'}}

"Tim Pope
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive', {'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-commentary'

"File Search and Navigation
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'vim-scripts/bufkill.vim'

"Editing Enhancements
NeoBundle 'godlygeek/tabular'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'kris89/vim-multiple-cursors'
NeoBundle 'ervandew/supertab'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'airblade/vim-gitgutter'
NeoBundleLazy 'mattn/emmet-vim', {'autoload':
    \ {'filetypes' : ['html', 'xhtml', 'xml']}}

"Screen Enhancements/Colors
NeoBundle 'bling/vim-airline'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'Lokaltog/powerline-fonts'
NeoBundle 'ap/vim-css-color'
"NeoBundle 'flazz/vim-colorschemes'
"NeoBundle 'zhaocai/GoldenView.Vim'

"Clojure
NeoBundle 'vim-scripts/paredit.vim'
NeoBundleLazy 'tpope/vim-fireplace', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'tpope/vim-classpath', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'guns/vim-clojure-static', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'kien/rainbow_parentheses.vim', {'autoload':
    \ {'filetypes' : ['clojure', 'javascript', 'html']}}

"Python
NeoBundleLazy 'klen/python-mode', {'autoload':
\ {'filetypes' : 'python'}}

"JavaScript
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':
\ {'filetypes' : 'javascript'}}
NeoBundleLazy 'moll/vim-node', {'autoload':
\ {'filetypes' : 'javascript'}}
NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload':
\ {'filetypes' : 'coffee'}}
NeoBundleLazy 'elzr/vim-json', {'autoload':
\ {'filetypes' : 'json'}}

"HTML
NeoBundleLazy 'othree/html5.vim', {'autoload':
\ {'filetypes' : 'html'}}

"LaTeX
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', {'autoload':
\ {'filetypes' : 'tex'}}


"Tooling
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'

"Misc
NeoBundle 'kana/vim-arpeggio'

"Deprecated
"NeoBundle 'thinca/vim-visualstar'
"NeoBundle 'vim-scripts/ZoomWin'
" NeoBundleLazy 'chrisbra/NrrwRgn', {'autoload':
"     \ {'commands' : 'NarrowRegion'}}
" NeoBundleLazy 'pangloss/vim-javascript', {'autoload':
" \ {'filetypes' : ['javascript', 'html']}}
"NeoBundleLazy 'mustache/vim-mustache-handlebars'
" NeoBundleLazy 'matthias-guenther/hammer.vim', {'autoload':
" \ {'filetypes' : 'markdown'}}
"NeoBundle 'kballenegger/vim-autoreadwatch'
"NeoBundle 'papanikge/vim-voogle'
" NeoBundleLazy 'sjl/gundo.vim', {'autoload':
"     \ {'commands' : 'GundoToggle'}}
"NeoBundle 'terryma/vim-multiple-cursors'
"NeoBundle 'vim-scripts/scratch.vim'

call neobundle#config('vimproc', {
\ 'build' : {
\       'windows' : 'make -f make_mingw64.mak',
\       'cygwin' : 'make -f make_cygwin.mak',
\       'mac' : 'make -f make_mac.mak',
\       'unix' : 'make -f make_unix.mak',
\   },
\ })

call neobundle#config('vimfiler', {
\ 'lazy' : 1,
\ 'depends' : 'Shougo/unite.vim',
\ 'autoload' : {
\       'commands' : [
\           {'name' : 'VimFiler',
\           'complete' : 'customlist,vimfiler#complete'},
\           {'name' : 'VimFilerTab',
\           'complete' : 'customlist,vimfiler#complete'},
\           {'name' : 'VimFilerExplorer',
\           'complete' : 'customlist,vimfiler#complete'},
\           {'name' : 'Edit',
\           'complete' : 'customlist,vimfiler#complete'},
\           {'name' : 'Write',
\           'complete' : 'customlist,vimfiler#complete'},
\           'Read', 'Source'],
\       'mappings' : '<Plug>vimfiler_',
\       'explorer' : 1,
\}})

if neobundle_installed == 0
    echo "Installing NeoBundles..."
    echo ""
    NeoBundleInstall
    source $MYVIMRC
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
"maximize gvim on open, set terminal to 256 colors
if has("gui_running")
    set lines=999 columns=999
else
    set t_Co=256
    let g:solarized_termcolors=256
endif

"change background color based on time of day
function! SetBackgroundTheme(theme)
    if (a:theme == 'light')
        set background=light
        colorscheme solarized
    else
        set background=dark
        colorscheme hybrid
    endif
endfunction

if strftime('%H') > 6 && strftime("%H") < 18
    call SetBackgroundTheme('light')
else
    call SetBackgroundTheme('dark')
endif

"Buffers
set number
set relativenumber
set ruler
set title
set lazyredraw
set cursorline
set autowrite       " automatically save before commands like :next and :make
set autoread        " automatically read a file if it's been changed on disk
set hidden          " hide buffers when they are abandoned
set history=1000
set ttimeout
set ttimeoutlen=50
syntax enable
filetype plugin indent on

"Tab/indent
set autoindent
set expandtab
set smarttab
set shiftround
set softtabstop=4
set shiftwidth=4
set scrolloff=8
set sidescrolloff=5
set backspace=indent,eol,start
set textwidth=80

set nrformats-=octal
set fileformats+=mac
set iskeyword+=-

set mouse=""
set shellslash
set ttyfast
if has("unix")
    set shell=bash
endif

"Search
set gdefault
set ignorecase      " do case insensitive matching
set smartcase       " do smart case matching
set incsearch       " incremental search
set showmatch       " show matching brackets.

"Window/menu
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list,full
set completeopt+=longest
set laststatus=2
set guioptions-=T
set guioptions+=c
set clipboard=unnamedplus
set display+=lastline
"set guitablabel=\[%N\]\ %t\ %M

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Disable temp and backup files
set wildignore+=*.exe,*/tmp/*,*\\tmp\\*,*.swp,*~,._*

" Disable non-text files
set wildignore+=*.doc*,*.ppt*,*.jpg,*.png,*.pdf,*/node_modules/*

"Swap files
set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.
set shortmess+=A

set grepprg=ack\ --smart-case\ --column\ --nogroup\ --nocolor\ --follow

augroup vimrc
    autocmd!
    "Jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FocusLost *.{html,css} w
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.html syntax enable
    autocmd BufRead,BufNewFile *.html set syntax=html
    autocmd BufRead,BufNewFile *.handlebars, *.hbs set filetype=html
    "stupid paredit mapping...
    autocmd BufRead,BufNewFile *.clj nunmap <buffer> s
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set relativenumber
    autocmd ColorScheme * AirlineTheme base16
augroup END

"open help in vsplit
augroup helpfiles
    autocmd!
    autocmd BufRead,BufEnter */doc/* set number
    autocmd BufRead,BufEnter */doc/* set relativenumber
    autocmd BufRead,BufEnter */doc/* wincmd L
augroup END

if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
call arpeggio#map('covi','', 0, 'tn', '<Esc>')

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

nnoremap Y y$

nnoremap yp "0p

nnoremap & :&&<CR>

nnoremap gV `[v`]

cnoremap w!! w !sudo tee % > /dev/null<CR>

"allows incsearch highlighting for range commands
"stole from reddit - does anyone use easymotion
cnoremap $t <CR>:t''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``

"Source a line of vimscript
"Good for small changes made to vimrc
nnoremap <Leader><Leader>s yy:<C-r>0<BS><CR>
nnoremap <silent> <Leader>sv :silent source $MYVIMRC \| AirlineRefresh<CR>

nnoremap <silent> <Leader>l :nohls<CR>

nnoremap <silent> <Leader>bp :b#<CR>
nnoremap <silent> <Leader>bd :BD<CR>

"break undo sequence when deleting a line in insert mode
inoremap <C-U> <C-G>u<C-U>

"make comment box using vim-commentary
nmap <Leader>cb O<Esc>50i=<Esc>yypOblah<Esc>kV2jgcj0wciw
nnoremap <Leader>ct :call MakeSectionTitle()<CR>
inoremap <C-t> <Esc>:call MakeSectionTitle()<CR>A

function! MakeSectionTitle()
    let l:section_title = getline(".")
    let l:length = strlen(l:section_title)
    let l:offset = 34 - (l:length / 2)
    execute "normal! 070R#\<Esc>0" . l:offset . "lR " . l:section_title . " \<Esc>"
    execute "normal gcc"
endfunction

"toggle cursorline and toggle background color
nnoremap <silent> <Leader>tc :set cursorline!<CR>
nnoremap <silent> <Leader>tb :call ColorToggle()<CR>

function! ColorToggle()
    if (&background == 'dark')
        call SetBackgroundTheme('light')
    else
        call SetBackgroundTheme('dark')
    endif
endfunction

"make current file executable
nnoremap <silent> <Leader>x :w<CR>:!chmod 755 %<CR>:e<CR>

"Window navigation commands
nnoremap <Leader>wv <C-w>v
nnoremap <Leader>ws <C-w>s
nnoremap <Leader>ww <C-w>w
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
nnoremap <Leader>wq <C-w>q
nnoremap <Leader>wc <C-w>c
nnoremap <Leader>wo <C-w>o
nnoremap <Leader>w= <C-w>=
noremap <silent> <Left> :vertical resize -10<CR>
noremap <silent> <Right> :vertical resize +10<CR>
noremap <silent> <Down> :resize -10<CR>
noremap <silent> <Up> :resize +10<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

nnoremap <silent> <Leader>nu :set relativenumber!<CR>

function! SaveAbbrev()
    let l:after = $HOME . '/.vim/after/plugin/'
    let l:abbrevs = l:after . 'abolish.vim'
    if !isdirectory(l:after)
        silent !mkdir -p ~/.vim/after/plugin
    endif
    if !filereadable(l:abbrevs)
        silent !touch ~/.vim/after/plugin/abolish.vim
    endif

    let g:ab_mistake = expand("<cword>")
    let g:ab_correction = input("Please enter the correct spelling: ")
    execute "normal! ciw" . g:ab_correction
    execute "edit ~/.vim/after/plugin/abolish.vim"
    execute "normal! GoAbolish" g:ab_mistake g:ab_correction
    execute "Abolish" g:ab_mistake g:ab_correction
    write
    BD
endfunction

nnoremap <Leader>ab :call SaveAbbrev()<CR>

function! FixTrailingSpaces()
    let l:save_cursor = getpos('.')
    silent! execute ":%s/\\s\\+$//"
    call setpos('.', l:save_cursor)
endfunction

nnoremap <Leader>fw :call FixTrailingSpaces()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Finish NeoBundle Setup
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleCheck
NeoBundleClean

""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimshell_prompt = '$ '
let g:vimshell_right_prompt = 'getcwd()'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_editor_command = 'vim'

nnoremap <silent> <Leader>vsv :vsp<CR>:VimShell<CR>
nnoremap <silent> <Leader>vst :tabe<CR>:VimShell<CR>
nnoremap <silent> <Leader>js :VimShellInteractive node<CR>
nnoremap <silent> <Leader>py :VimShellInteractive python3.3<CR>
nnoremap <silent> <Leader>fr :VimShellInteractive lein repl<CR>
nnoremap <silent> <Leader>vx :VimShellExecute
nnoremap <silent> <Leader>ve :VimShellSendString<CR>
vnoremap <silent> <Leader>ve :VimShellSendString<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoComplete Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#enable_fuzzy_completion = 1

let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME . '/.cache/vimshell/command-history'}
let g:neocomplete#sources#vim#complete_functions = {
    \ 'Ref' : 'ref#complete',
    \ 'Unite' : 'unite#complete_source',
    \ 'VimShellExecute' : 'vimshell#vimshell_execute_complete',
    \ 'VimShellInteractive' : 'vimshell#vimshell_execute_complete',
    \ 'VimShellTerminal' : 'vimshell#vimshell_execute_complete',
    \ 'VimShell' : 'vimshell#complete',
    \ 'VimFiler' : 'vimfiler#complete'}

augroup neocomplete
    autocmd!
    autocmd BufEnter *vimshell* call s:neocomplete_enter()
    autocmd BufLeave *vimshell* call s:neocomplete_leave()
augroup END

function! s:neocomplete_enter()
    NeoCompleteEnable
    inoremap <buffer> <expr> <Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
    inoremap <buffer> <expr> <S-Tab> pumvisible() ? "\<C-n>" : "\<S-Tab>"
    inoremap <buffer> <expr> <Space> pumvisible() ? neocomplete#close_popup() . "\<Space>" : "\<Space>"
    inoremap <buffer> <expr> <CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

function! s:neocomplete_leave()
    NeoCompleteDisable
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_max_cache_files = 5000

let g:junkfile#directory=expand("~/.vim/.cache/junk")

if executable('ack-grep')
    let g:unite_source_grep_command = "ack-grep"
    let g:unite_source_grep_default_opts = '--line-numbers --nogroup -a -w'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    let g:unite_source_grep_command = "ack"
    let g:unite_source_grep_default_opts = '--line-numbers --nogroup -a -w'
    let g:unite_source_grep_recursive_opt = ''
endif


call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep,outline,yank',
    \ 'ignore_pattern', join(['\.git/', '\.pptx$', '\.docx$', '\.jpg$',
    \ '\.png$', '\.pdf$', '\.gif$', '\.tar\.gz$', '\.zip$', '\.deb$', '/node_modules/', '.config/*'], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <Leader>uf :<C-u>Unite -no-split -buffer-name=files file_mru file<CR>
nnoremap <Leader>ur :<C-u>Unite -no-split -buffer-name=files file_rec/async:~/Projects<CR>
nnoremap <Leader>up :<C-u>Unite -no-split -buffer-name=project_files file_rec/async:!<CR>
nnoremap <Leader>ud :<C-u>Unite -no-split -buffer-name=directory directory:~<CR>

nnoremap <Leader>uy :<C-u>Unite -buffer-name=yanks history/yank<CR>
nnoremap <Leader>ug :<C-u>Unite -auto-resize -buffer-name=grep grep:.<CR>
nnoremap <Leader>ub :<C-u>Unite -auto-resize -buffer-name=buffers buffer<CR>
nnoremap <Leader>uj :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<CR>
nnoremap <Leader>uh :<C-u>Unite -auto-resize -buffer-name=help help<CR>

nnoremap <Leader>uo :<C-u>Unite -no-split -buffer-name=outline outline<CR>
nnoremap <Leader>ps :<C-u>Unite -no-split -buffer-name=processes  process<CR>
nnoremap <Leader>us :<C-u>Unite -no-split -buffer-name=session  session session/new<CR>

augroup unite
    autocmd!
    autocmd FileType unite call s:unite_settings()
augroup END

function! s:unite_settings()
    let b:SuperTabDisabled=1
    set number
    set relativenumber
    silent! iunmap <C-g>s
    silent! iunmap <C-g>S
    nnoremap <silent><buffer><expr> s unite#do_action('split')
    nnoremap <silent><buffer><expr> v unite#do_action('vsplit')
    nnoremap <silent><buffer><expr> r unite#do_action('rec/async')
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <C-r> unite#do_action('rec/async')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "mysnippets"]
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Sneak Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
highlight SneakPluginTarget None

""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle=3

""""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow Parentheses Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let bundle = neobundle#get('rainbow_parentheses.vim')
function! bundle.hooks.on_source(bundle)
    autocmd VimEnter * RainbowParenthesesActivate
    autocmd BufEnter * RainbowParenthesesActivate
    autocmd ColorScheme * RainbowParenthesesActivate

    autocmd Syntax * RainbowParenthesesLoadBraces
    autocmd Syntax * RainbowParenthesesLoadChevrons
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
if exists(":Tabularize")
    nnoremap <silent> <Leader>t= :Tabularize /=<CR>
    vnoremap <silent> <Leader>t= :Tabularize /=<CR>
    nnoremap <silent> <Leader>t: :Tabularize /:\zs<CR>
    vnoremap <silent> <Leader>t: :Tabularize /:\zs<CR>
    nnoremap <silent> <Leader>t| :Tabularize /<Bar><CR>
    vnoremap <silent> <Leader>t| :Tabularize /<Bar><CR>
    nnoremap <silent> <Leader>ta :Tabularize /
    vnoremap <silent> <Leader>ta :Tabularize /
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fireplace Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>fdj yiw:Djump <C-r>0<CR>
nnoremap <silent> <Leader>fds yiw:Dsplit <C-r>0<CR>
nnoremap <silent> <Leader>fe :%Eval<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_map_keys = 0
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap <Leader>ha :GitGutterStageHunk<CR>
nnoremap <Leader>hr :GitGutterRevertHunk<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gl :Glog<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>ga :Gwrite<CR>
nnoremap <silent> <Leader>gr :Gremove!<CR>
nnoremap <silent> <Leader>gp :Git push origin master<CR>
nnoremap <silent> <Leader>gh :Git push heroku master<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
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

" ================ Paredit Settings ================
let g:paredit_leader="<Space>"

""""""""""""""""""""""""""""""""""""""""""""""""""
" Cheat Sheet
""""""""""""""""""""""""""""""""""""""""""""""""""
"#Fugitive:
    " - <Leader>gs - Gstatus
    "     - Type - on any file to stage or unstage it
    "     - Type p on any file to enter and stage specific hunks in the file
    " - <Leader>gb - Gblame
    " - <Leader>gd - Gdiff
    " - <Leader>gl - Glog
    " - <Leader>gc - Gcommit
    " - <Leader>gp - Gpush
"#Multiple-Cursors
    " - <c-n> -> select next
    " - <c-p> -> undo selection and move to previous
    " - <c-x> -> skip current selection
"#Paredit
    " - [[             -> go to start of current/previous defn
    " - ]]             -> go to start of next defn
    " - <Leader><      -> if standing on a delimiter moves the delimeter to the left
    "                 -> either slurping or barfing depending on delimeter
    " - <Leader>>      -> if standing on a delimiter moves the delimiter to the right
    " - <Leader>J      -> join two subsequent lists or strings
"     - <Leader>O      -> split ("open") current list or string
    "                 -> Opposite of <Leader>J command
    " - <Leader>w(     -> wrap current symbol in parantheses
    "                 -> Can also use <Leader>W
"                     -> Can use other delimiters instead of (, i.e. [{"
    " - <Leader>S      -> splice the current list into the outer list
    "                 -> Opposite of wrap
    " - <Leader><Up>   -> splice killing backward in inner list
    "                 -> (aaa (bbb |ccc) ddd) ===> (aaa |ccc ddd)
    " - <Leader><Down> -> splice killing forward in inner list
    "                 -> (aaa (bbb| ccc) ddd) ===> (aaa |bbb ddd)
    " - <Leader>I      -> raise current symbol by splicing and killing all other symbols in inner list
    "                 -> (aaa (b|bb ccc) ddd) ===> (aaa |bbb ddd)
"#NrrwRgn
    " - :NarrowRegion -> export currently selected region to scratch buffer
"#Fireplace
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
"#Vim-Commentary
    " - gc{motion} -> toggle comments for small inline comments
    " - gcc        -> toggle comments for current line
    " - gC{motion} -> comment region
"#Emmet
    " - <C-y>, -> expand/wrap with css-style abbreviation
    " - <C-y>n -> go to next edit point (N for previous)
    " - <C-y>k -> kill tag in block
    " - <C-y>/ -> toggle comment for tag
    " - <C-y>a -> make anchor from URL
    " - <C-y>A -> make quoted text from URL
    " - <C-y>c -> pretty code formatting
