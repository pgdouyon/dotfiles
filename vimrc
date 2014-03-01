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
        silent !mkdir -p ~/.vim/bundle
        silent !mkdir -p ~/.vim/_backup
        silent !mkdir -p ~/.vim/_temp
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
NeoBundle 'Shougo/vimfiler.vim'
NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':
    \ {'commands' : 'NeoCompleteEnable'}}

"Tim Pope
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive', {'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-abolish'
"NeoBundle 'tpope/vim-dispatch'
"NeoBundle 'tpope/vim-sensible'
" NeoBundleLazy 'tpope/vim-eunuch', {'autoload':
"     \ {'commands' : ['SudoWrite', 'Locate', 'Find', 'Chmod', 'Move', 'Remove']}}

"File Search and Navigation
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'vim-scripts/bufkill.vim'
"NeoBundle 'mileszs/ack.vim'
"NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'scrooloose/nerdtree'

"Editing Enhancements
NeoBundle 'godlygeek/tabular'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'ervandew/supertab'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'vim-scripts/ZoomWin'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundleLazy 'sjl/gundo.vim', {'autoload':
    \ {'commands' : 'GundoToggle'}}
NeoBundleLazy 'mattn/emmet-vim', {'autoload':
    \ {'filetypes' : ['html', 'xhtml', 'xml']}}
NeoBundleLazy 'chrisbra/NrrwRgn', {'autoload':
    \ {'commands' : 'NarrowRegion'}}
"NeoBundle 'sk1418/Join'
"NeoBundle 'maxbrunsfeld/vim-yankstack'
"NeoBundle 'thinca/vim-visualstar'
" NeoBundle 'bronson/vim-trailing-whitespace'

"Screen Enhancements/Colors
NeoBundle 'bling/vim-airline'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'Lokaltog/powerline-fonts'
NeoBundle 'ap/vim-css-color'
"NeoBundle 'flazz/vim-colorschemes'

"Clojure
NeoBundleLazy 'tpope/vim-fireplace', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'tpope/vim-classpath', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'guns/vim-clojure-static', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'vim-scripts/paredit.vim', {'autoload':
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
" NeoBundleLazy 'pangloss/vim-javascript', {'autoload':
" \ {'filetypes' : ['javascript', 'html']}}

"HTML
NeoBundleLazy 'othree/html5.vim', {'autoload':
\ {'filetypes' : 'html'}}
"NeoBundleLazy 'vim-scripts/indenthtml.vim'
"NeoBundleLazy 'mustache/vim-mustache-handlebars'
" NeoBundleLazy 'tpope/vim-markdown', {'autoload':
" \ {'filetypes' : 'markdown'}}

"LaTeX
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', {'autoload':
\ {'filetypes' : 'tex'}}


"Tooling
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mattn/gist-vim'
" NeoBundleLazy 'matthias-guenther/hammer.vim', {'autoload':
" \ {'filetypes' : 'markdown'}}
"NeoBundle 'kballenegger/vim-autoreadwatch'

"Misc
NeoBundle 'vim-scripts/scratch.vim'
"NeoBundle 'papanikge/vim-voogle'

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
if strftime('%H') > 6 && strftime("%H") < 18
    set background=light
else
    set background=dark
endif
colorscheme solarized

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
set history=300
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

set mouse=""
set shellslash
set ttyfast
if has("unix")
    set shell=bash
else
    "need shell when not on linux
    "set shell=ksh.exe
endif

"Search
set hlsearch
set ignorecase      " do case insensitive matching
set smartcase       " do smart case matching
set incsearch       " incremental search
set showmatch       " show matching brackets.

"Window/menu
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list,full
set laststatus=2
set guioptions-=T
set clipboard+=unnamed
set display+=lastline

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

augroup mycommands
    au!
    "Jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au FocusLost *.{html,css} w
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.html syntax enable
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set relativenumber
augroup END

"open help in vsplit
augroup helpfiles
    au!
    au BufRead,BufEnter */doc/* wincmd L
augroup END

if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap hd <Esc>l
onoremap hd <Esc>l
vnoremap hd <Esc>l
inoremap hd <Esc>l

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$

nnoremap * *N
nnoremap # #N

"Source a line of vimscript
"Good for small changes made to vimrc
nnoremap <Leader><Leader>s yy:<C-r>0<BS><CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

"make comment box using tcomment
nmap <Leader>cb o<Esc>50i=<Esc>yypOblah<Esc>kV2jgcj0wciw

nnoremap <silent> <Leader>l :nohls<CR>

nnoremap <silent> <Leader>bp :b#<CR>
nnoremap <silent> <Leader>bd :BD<CR>

inoremap <C-U> <C-G>u<C-U>

"toggle cursorline and toggle background color
nnoremap <Leader>tc :set <C-R>=&cursorline ? 'nocursorline' : 'cursorline'<CR><CR>
nnoremap <Leader>tb :set background=<C-R>=&background=='light' ? 'dark' : 'light'<CR><CR>

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

nnoremap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

function! NumberToggle()
    if(&relativenumber==1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <silent> <Leader>nu :call NumberToggle()<CR>

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
    execute "normal ciw" . g:ab_correction
    execute "edit ~/.vim/after/plugin/abolish.vim"
    execute "normal GoAbolish" g:ab_mistake g:ab_correction
    execute "Abolish" g:ab_mistake g:ab_correction
    write
    BD
endfunction

nnoremap <Leader>ab :call SaveAbbrev()<CR>

function! FixTrailingSpaces()
    let l:save_cursor = getpos(".")
    silent! execute ":%s/\s\+$//"
    call setpos(".", l:save_cursor)
endfunction

nnoremap <Leader>fw call FixTrailingSpaces()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Finish NeoBundle Setup
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleCheck
NeoBundleClean

""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimshell_prompt = '$ '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'

nmap <silent> <Leader>vsv :vsp<CR>:VimShell<CR>
nmap <silent> <Leader>vst :tabe<CR>:VimShell<CR>
nmap <silent> <Leader>py :VimShellInteractive python3.3<CR>
nmap <silent> <Leader>fr :VimShellInteractive lein repl<CR>
nmap <silent> <Leader>vx :VimShellExecute
nmap <silent> <Leader>ve :VimShellSendString<CR>
vmap <silent> <Leader>ve :VimShellSendString<CR>

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
    au!
    autocmd BufEnter *vimshell* call s:neocomplete_enter()
    autocmd BufLeave *vimshell* call s:neocomplete_leave()
augroup END

function! s:neocomplete_enter()
    NeoCompleteEnable
    inoremap <buffer> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <buffer> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction

function!s:neocomplete_leave()
    NeoCompleteDisable
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:unite_force_overwrite_statusline = 0
let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_max_cache_files = 5000

if executable('ack-grep')
    let g:unite_source_grep_command = "ack-grep"
    let g:unite_source_grep_default_opts = '--line-numbers --nogroup -a -w'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    let g:unite_source_grep_command = "ack"
    let g:unite_source_grep_default_opts = '--line-numbers --nogroup -a -w'
    let g:unite_source_grep_recursive_opt = ''
endif


call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep,outline,yank',
    \ 'ignore_pattern', join(['\.git/', '\.pptx$', '\.docx$', '\.jpg$',
    \ '\.png$', '\.pdf$', '\.gif$', '\.tar\.gz$', '\.zip$', '\.deb$', '/node_modules/', '.config/*'], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <Leader>uf :<C-u>Unite -no-split -buffer-name=files -start-insert file file_mru<CR>
nnoremap <Leader>ud :<C-u>Unite -no-split -buffer-name=files -start-insert file:
nnoremap <Leader>ur :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:~/Projects
nnoremap <Leader>up :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<CR>

nnoremap <Leader>ub :<C-u>Unite -resume -buffer-name=buffers -no-start-insert buffer<CR>

nnoremap <Leader>uy :<C-u>Unite -resume -buffer-name=yanks -quick-match history/yank<CR>
nnoremap <Leader>ug :<C-u>Unite -no-split -buffer-name=grep grep:.<CR>
nnoremap <Leader>uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<CR>

augroup unite
    au!
    autocmd FileType unite call s:unite_settings()
augroup END

function! s:unite_settings()
    let b:SuperTabDisabled=1
    nmap <silent><buffer><expr> s unite#do_action('split')
    nmap <silent><buffer><expr> v unite#do_action('vsplit')
    imap <silent><buffer><expr> <C-s> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
" set rtp+=~/.vim/bundle/vim-snippets/
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "mysnippets"]
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" let bundle = neobundle#get('ultisnips')
" function! bundle.hooks.on_source(bundle)
"     let g:UltiSnips.always_use_first_snippet = 1
" endfunction
"
""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Seek Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:seek_enable_jumps = 1
"r - remote iw
"p - jump iw
"u - remote aw
"o - jump aw

""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <F5> :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle=3

""""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow Parentheses Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let bundle = neobundle#get('rainbow_parentheses.vim')
function! bundle.hooks.on_source(bundle)
    au VimEnter * RainbowParenthesesActivate
    au BufEnter * RainbowParenthesesActivate
    au ColorScheme * RainbowParenthesesActivate

    au Syntax * RainbowParenthesesLoadBraces
    au Syntax * RainbowParenthesesLoadChevrons
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
if exists(":Tabularize")
    nmap <silent> <Leader>t= :Tabularize /=<CR>
    vmap <silent> <Leader>t= :Tabularize /=<CR>
    nmap <silent> <Leader>t: :Tabularize /:\zs<CR>
    vmap <silent> <Leader>t: :Tabularize /:\zs<CR>
    nmap <silent> <Leader>t| :Tabularize /<Bar><CR>
    vmap <silent> <Leader>t| :Tabularize /<Bar><CR>
endif

nmap <silent> <Leader>ta :Tabularize /
vmap <silent> <Leader>ta :Tabularize /

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fireplace Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>fdj yiw:Djump <C-r>0<CR>
nnoremap <silent> <Leader>fds yiw:Dsplit <C-r>0<CR>
nnoremap <silent> <Leader>fe :%Eval<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>gb :Gblame<CR>
nmap <silent> <Leader>gs :Gstatus<CR>
nmap <silent> <Leader>gd :Gdiff<CR>
nmap <silent> <Leader>gl :Glog<CR>
nmap <silent> <Leader>gc :Gcommit<CR>
nmap <silent> <Leader>gp :Git push origin master<CR>
nmap <silent> <Leader>gh :Git push heroku master<CR>

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
" let g:airline_left_sep=""
" let g:airline_right_sep=""
set fillchars+=stl:\ ,stlnc:\

""""""""""""""""""""""""""""""""""""""""""""""""""
" ZoomWin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>zw :ZoomWin<CR>

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
"#TComment
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
