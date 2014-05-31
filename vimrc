""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle Setup
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    set nocompatible
    set encoding=utf-8
    "I don't know why people always use the ',' key...
    let mapleader="\<Space>"
    let maplocalleader="\<CR>"
    filetype off

    let neobundle_installed=1
    let neobundle_script=expand('~/.vim/bundle/neobundle.vim/autoload/neobundle.vim')
    if !filereadable(neobundle_script)
        if !executable("git")
            echo "Git must be installed to finish setup..."
            finish
        endif

        echo "Installing NeoBundle..."
        echo ""
        call mkdir($HOME . "/.vim/bundle", "p")
        call mkdir($HOME . "/.vim/_backup", "p")
        call mkdir($HOME . "/.vim/_temp", "p")

        execute "silent !git clone https://github.com/Shougo/neobundle.vim " . $HOME . "/bundle/neobundle.vim"
        let neobundle_installed=0
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

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
NeoBundle 'Shougo/neocomplete.vim'

" Tim Pope
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive', {'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'
" NeoBundle 'tpope/timl'

" Editing Enhancements (IDE features)
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'kris89/vim-multiple-cursors'
NeoBundle 'ervandew/supertab'
NeoBundle 'SirVer/ultisnips'

" Text Objects
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'coderifous/textobj-word-column.vim'

" Window/Buffer Management
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundle 'zhaocai/GoldenView.Vim'
NeoBundle 'chrisbra/NrrwRgn'

" GUI Plugins
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/powerline-fonts'
NeoBundle 'mikewest/vimroom'

" ColorSchemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'chriskempson/base16-vim'

" Tool Integration
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'

" Misc
NeoBundle 'kana/vim-arpeggio'

" Clojure
NeoBundle 'guns/vim-sexp'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundleLazy 'tpope/vim-fireplace', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'tpope/vim-classpath', {'autoload':
    \ {'filetypes' : 'clojure'}}
NeoBundleLazy 'guns/vim-clojure-static', {'autoload':
    \ {'filetypes' : 'clojure'}}

" Python
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

" HTML
NeoBundleLazy 'othree/html5.vim', {'autoload':
    \ {'filetypes' : 'html'}}
NeoBundleLazy 'mattn/emmet-vim', {'autoload':
    \ {'filetypes' : ['html', 'xhtml', 'xml']}}

" CSS
NeoBundleLazy 'ap/vim-css-color', {'autoload':
    \ {'filetypes' : 'css'}}
" NeoBundle 'flazz/vim-colorschemes'

" Markdown
NeoBundleLazy 'vim-pandoc/vim-pandoc-syntax', {'autoload':
    \ {'filetypes' : ['markdown', 'tex']}}

" LaTeX
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', {'autoload':
    \ {'filetypes' : 'tex'}}

" Deprecated
" NeoBundle 'vim-scripts/ZoomWin'
" NeoBundleLazy 'mustache/vim-mustache-handlebars'
" NeoBundleLazy 'matthias-guenther/hammer.vim', {'autoload':
    " \ {'filetypes' : 'markdown'}}
" NeoBundle 'kballenegger/vim-autoreadwatch'
" NeoBundle 'papanikge/vim-voogle'
" NeoBundleLazy 'sjl/gundo.vim', {'autoload':
    " \ {'commands' : 'GundoToggle'}}
" NeoBundle 'godlygeek/tabular'

call neobundle#config('vimproc.vim', {
    \ 'build' : {
        \       'windows' : 'make -f make_mingw64.mak',
        \       'cygwin' : 'make -f make_cygwin.mak',
        \       'mac' : 'make -f make_mac.mak',
        \       'unix' : 'make -f make_unix.mak',
        \   }})

call neobundle#config('vimfiler.vim', {
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
    \       'explorer' : 1}})

if neobundle_installed == 0
    echo "Installing NeoBundles..."
    echo ""
    NeoBundleInstall!
    source $MYVIMRC
endif

call neobundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
"maximize gvim on open, set terminal to 256 colors
filetype plugin indent on
syntax on

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
        call s:FixGitGutterSignColumn()
    else
        set background=dark
        colorscheme hybrid
    endif
    " make comments more visible
    highlight clear Comment
    highlight link Comment Todo
endfunction

function! s:FixGitGutterSignColumn()
    let oldz = @z
    redir @z
    silent highlight LineNr
    redir END

    let guibg = matchstr(@z, '\vguibg\=%(\a+|\#\x+)')
    execute "silent! highlight SignColumn " . guibg
    execute "silent! highlight GitGutterAddDefault " . guibg
    execute "silent! highlight GitGutterChangeDefault " . guibg
    execute "silent! highlight GitGutterDeleteDefault " . guibg
    let @z = oldz
endfunction

"change background color based on time of day
if strftime('%H') > 6 && strftime("%H") < 18
    call s:SetBackgroundTheme('light')
else
    call s:SetBackgroundTheme('dark')
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

"Tab/indent
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
set fileformats+=mac
set iskeyword+=-

set mouse=""            " the mouse is the devil, don't allow it
set shellslash          " use forward slashes for file names
set ttyfast             " demand better performance when in terminal
if has("unix")
    set shell=bash
endif

"Search
set gdefault        " all substiutions have 'g' flag on by default
set ignorecase      " do case insensitive matching
set smartcase       " do smart case matching
set incsearch       " incremental search
set showmatch       " show matching brackets.

"Window/menu
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list,full  " first complete as much as possible, then show list, then select next match
set completeopt+=longest
set laststatus=2                " always show status line
set guioptions-=T               " turn off Toolbar
set guioptions+=c               " use console dialogs instead of popup dialogs
set clipboard=unnamedplus       " system clipboard uses unnamed register (don't ask why =unnamed didn't work....)
set display+=lastline           " get rid of those ugly '@' that Vim puts after the last line in the window
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
set backupdir^=~/.vim/_backup//     " where to put backup files.
set directory^=~/.vim/_temp//       " where to put swap files.
set shortmess+=A                    " no 'existing swap file found' messages

set grepprg=ack\ --smart-case\ --column\ --nogroup\ --nocolor\ --follow

augroup vimrc
    autocmd!
    "Jump to the last position when reopening a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FocusLost *.{html,css} w
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.handlebars, *.hbs set filetype=html
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set relativenumber
    "reload AirlineTheme because the tab bar gets effed up
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
" Vimrc Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
call arpeggio#map('covi','', 0, 'tn', '<Esc>')

" make j and k operate over display lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" center the jump on screen
nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zt
nnoremap <C-i> <C-i>zt

" simplify inline navigation
nnoremap H ^
nnoremap L $
nnoremap ^ H
nnoremap $ L

" make Y play nice like C and D do
nnoremap Y y$

" yank-paste -> paste the last yank
nnoremap yp "0p

" reuse flags when repeating substitute command with &
nnoremap & :&&<CR>

" highlight last inserted text
nnoremap gV `[v`]

" write file with super user privileges
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

" switch to alternate buffer and delete buffer using BufKill plugin to keep window
nnoremap <silent> <Leader>bp :b#<CR>
nnoremap <silent> <Leader>bd :BD<CR>

"break undo sequence when deleting a line in insert mode
inoremap <C-U> <C-G>u<C-U>

"make comment box using vim-commentary
nmap <Leader>cb O<Esc>50i=<Esc>yypOblah<Esc>kV2jgcj0wciw
nnoremap <Leader>ct :call <SID>MakeSectionTitle()<CR>
inoremap <C-t> <Esc>:call <SID>MakeSectionTitle()<CR>A

function! s:MakeSectionTitle()
    let l:section_title = getline(".")
    let l:length = strlen(l:section_title)
    let l:offset = 34 - (l:length / 2)
    execute "normal! 070R#\<Esc>0" . l:offset . "lR " . l:section_title . " \<Esc>"
    execute "normal gcc"
endfunction

"toggle background color
nnoremap <silent> <Leader>tb :call <SID>ColorToggle()<CR>

function! s:ColorToggle()
    if (&background == 'dark')
        call s:SetBackgroundTheme('light')
    else
        call s:SetBackgroundTheme('dark')
    endif
endfunction

"make current file executable
nnoremap <silent> <Leader>x :w<CR>:!chmod 755 %<CR>:e<CR>

"Window navigation commands
nnoremap gw <C-w>
nnoremap <silent> <Leader>tc :tabc<CR>
nnoremap <silent> <Leader>to :tabe<CR>
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

nnoremap <silent> <Leader>nu :set relativenumber!<CR>

function! s:SaveAbbrev()
    let l:after = $HOME . '/.vim/after/plugin/'
    let l:abbrevs = l:after . 'abolish.vim'
    if !isdirectory(l:after)
        silent !mkdir -p ~/.vim/after/plugin
    endif
    if !filereadable(l:abbrevs)
        silent !touch ~/.vim/after/plugin/abolish.vim
    endif

    " get word under cursor and get correct spelling as input
    let g:ab_mistake = expand("<cword>")
    let g:ab_correction = input("Please enter the correct spelling: ")
    execute "normal! ciw" . g:ab_correction
    execute "edit ~/.vim/after/plugin/abolish.vim"
    execute "normal! GoAbolish" g:ab_mistake g:ab_correction
    execute "Abolish" g:ab_mistake g:ab_correction
    write
    BD
endfunction

nnoremap <Leader>ab :call <SID>SaveAbbrev()<CR>

function! s:FixTrailingSpaces()
    let l:save_cursor = getpos('.')
    silent! execute ":%s/\\s\\+$//"
    call setpos('.', l:save_cursor)
endfunction

nnoremap <Leader>fw :call <SID>FixTrailingSpaces()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Finish NeoBundle Setup
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleCheck
NeoBundleClean!

""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimshell_prompt = '$ '
let g:vimshell_right_prompt = 'strftime("%a %b %d  %H:%M %p")'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_editor_command = 'vim'

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
    autocmd BufEnter *vimshell* call <SID>neocomplete_enter()
augroup END

function! s:neocomplete_enter()
    NeoCompleteUnlock
    inoremap <buffer> <expr> <S-Tab> pumvisible() ? "\<C-n>" : "\<S-Tab>"
    inoremap <buffer> <expr> <Space> pumvisible() ? neocomplete#close_popup() . "\<Space>" : "\<Space>"
    inoremap <buffer> <expr> <CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_max_cache_files = 5000

if !isdirectory($HOME . "/.vim/.cache/junk")
    call mkdir($HOME . "/.vim/.cache/junk", "p")
endif
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

nnoremap <Leader>uf :<C-u>Unite -no-split -buffer-name=files file_mru file file/new<CR>
nnoremap <Leader>ur :<C-u>Unite -no-split -buffer-name=files file_rec/async:~/Projects<CR>
nnoremap <Leader>up :<C-u>Unite -no-split -buffer-name=project_files file_rec/async:!<CR>
nnoremap <Leader>ud :<C-u>Unite -no-split -buffer-name=directory directory:~ directory/new<CR>

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
    autocmd FileType unite call <SID>unite_settings()
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
highlight SneakPluginTarget None

""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle=3

""""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow Parentheses Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
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
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap gha <Plug>GitGutterStageHunk
nmap ghr <Plug>GitGutterRevertHunk

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

""""""""""""""""""""""""""""""""""""""""""""""""""
" GoldenView Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goldenview__enable_at_startup = 0
let g:goldenview__enable_default_mapping = 0
nmap <silent> <F5> <Plug>GoldenViewSplit
nmap <silent> <F6> <Plug>GoldenViewSwitchMain
nmap <silent> <F7> <Plug>GoldenViewSwitchToggle

""""""""""""""""""""""""""""""""""""""""""""""""""
" Narrow Region
""""""""""""""""""""""""""""""""""""""""""""""""""
xmap <silent> <Leader>nr <Plug>NrrwrgnBangDo
xmap <silent> <Leader>ns <Plug>NrrwrgnDo

""""""""""""""""""""""""""""""""""""""""""""""""""
" VimRoom
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimroom_width = 120
nmap <silent> <Leader>vr <Plug>VimroomToggle

""""""""""""""""""""""""""""""""""""""""""""""""""
" Cheat Sheet
""""""""""""""""""""""""""""""""""""""""""""""""""
"#Multiple-Cursors
    " - <c-n> -> select next
    " - <c-p> -> undo selection and move to previous
    " - <c-x> -> skip current selection
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
