" ======================================================================
" Vim-Plug Bundles
" ======================================================================

call plug#begin('$XDG_CONFIG_HOME/nvim/bundle')

" Personal Plugins
Plug 'pgdouyon/vim-niffler'
Plug 'pgdouyon/vim-apparate'
Plug 'pgdouyon/vim-evanesco'
Plug 'pgdouyon/vim-protean'
Plug 'pgdouyon/vim-accio'
Plug 'pgdouyon/vim-yin-yang'

" Tim Pope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Editing Enhancements
Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}

" Text Objects
Plug 'michaeljsmith/vim-indent-object'

" Appearance
Plug 'romainl/Apprentice'
Plug 'jonathanfilip/vim-lucius'
Plug 'whatyouhide/vim-gotham'

" Tool Integration
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'rizzatti/dash.vim', {'on': ['Dash', '<Plug>DashSearch']}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

" Languages
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-salve', {'for': 'clojure'}
Plug 'derekwyatt/vim-scala'
Plug 'elzr/vim-json'
Plug 'vim-ruby/vim-ruby'
Plug 'rstacruz/sparkup', {'rtp': 'vim', 'for': ['html', 'xml', 'ftl']}
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml', 'ftl']}
Plug 'tpope/vim-markdown'
Plug 'chaquotay/ftl-vim-syntax'

call plug#end()


" ======================================================================
" Options
" ======================================================================

" Don't set these after startup, can mess up local values and setglobal is borked
if has('vim_starting')
    set tags=./tags;/
    set synmaxcol=500
    set formatoptions=roq2lj
    set autoindent
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set nofoldenable
    set undofile
endif

" Leader
let mapleader="\<Space>"
let maplocalleader="\<CR>"

" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase

" Displaying text
set list
set nowrap
set linebreak
set lazyredraw
set scrolloff=1
set sidescrolloff=5
set conceallevel=2
set display+=lastline
set fillchars+=stl:\ ,stlnc:\ ,diff:-
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Multiple Windows
set laststatus=2
set statusline=%!statusline#schmexy_statusline()
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
set complete=.,w,b,u
set completeopt=menu,preview
set nrformats-=octal
set matchpairs+=<:>

" Tabs/Indenting
set smarttab
set shiftround

" Folding
set foldopen=insert,mark,quickfix,search,tag,undo
set foldtext=foldtext#schmexy_foldtext()

" Diff Mode
set diffopt=filler,vertical
set diffexpr=EnhancedDiff#Diff('git\ diff',\ '--diff-algorithm=patience')

" Mapping
set ttimeout
set ttimeoutlen=20

" Reading/Writing Files
set autoread

" Swap Files
set noswapfile
set directory^=~/.vim/_temp//

" Command Line Editing
set wildmenu
set wildignorecase
set wildmode=list:longest,full
set wildignore+=*.o,*.out,*.obj,*.class,*.exe,*.git,*.pyc,*.rbc,*.rbo,*.gem,*/node_modules/*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar
set wildignore+=**/tmp/*,*.swp,*~
set wildignore+=*.doc*,*.ppt*,*.jpg,*.png,*.pdf
set undodir=/tmp/

" Executing External Commands
set shellslash
set noshelltemp
if has("unix")
    set shell=bash
endif

" Various
set gdefault
set sessionoptions-=options

let g:is_bash = 1
let g:sql_type_default = 'mysql'


" ======================================================================
" Mappings
" ======================================================================

" ----------------------------------------------------------------------
" Normal Mode
" ----------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
xnoremap j gj
xnoremap k gk
xnoremap gj j
xnoremap gk k

nnoremap gh gT
nnoremap gl gt

noremap _ -

nnoremap Q @q

nnoremap <silent> du :diffupdate<CR>
nnoremap <silent> do :<C-U>call diff#diffget()<CR>
nnoremap <silent> dp :<C-U>call diff#diffput()<CR>

nnoremap <Leader>sv :silent source $MYVIMRC<CR>

nnoremap <silent> <BS> :buffer #<CR>

nnoremap <silent> <Leader>r :redraw!<Esc>

nnoremap <C-E> 2<C-E>
nnoremap <C-Y> 2<C-Y>
nnoremap zh 10zh
nnoremap zl 10zl

" fix {,} motions in files with trailing whitespace
nnoremap <silent> { m':call search('^\s*$\n\s*\S', 'bW')<CR>
nnoremap <silent> } m':call search('^\s*$\n\s*\S', 'W')<CR>
onoremap <silent> { :mark ' \| call search('^\s*$\n\s*\S', 'bW')<CR>
onoremap <silent> } :mark ' \| call search('^\s*$\n\s*\S', 'W')<CR>
xnoremap <silent> { :<C-U>execute "normal! m'gv" <Bar> call search('^\s*$\n\s*\S', 'bW')<CR>
xnoremap <silent> } :<C-U>execute "normal! m'gv" <Bar> call search('^\s*$\n\s*\S', 'W')<CR>

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
nmap g] g<C-]>

" ----------------------------------------------------------------------
" Comment/Duplicate Lines
" ----------------------------------------------------------------------
nmap z/   yygccp
xmap z/   V<Esc>gvygvgc`>p

" ----------------------------------------------------------------------
" Insert Mode
" ----------------------------------------------------------------------
" break undo sequence when deleting a line in insert mode
inoremap <C-U> <C-G>u<C-U>

inoremap <C-]> <C-X><C-]>
inoremap <C-K> <C-X><C-K>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>

inoremap <C-A> <Home>
inoremap <expr> <C-E> pumvisible() ? "\<C-E>" : "\<End>"

" can type with <C-/>
inoremap <C-_> <C-A>

" ----------------------------------------------------------------------
" Command Line
" ----------------------------------------------------------------------
" write file with super user privileges
cabbrev w!! w !sudo tee % > /dev/null

cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" ----------------------------------------------------------------------
" Terminal
" ----------------------------------------------------------------------
if has("nvim")
    tmap <C-H> <C-\><C-N><C-H>
    tmap <C-J> <C-\><C-N><C-J>
    tmap <C-K> <C-\><C-N><C-K>
    tmap <C-L> <C-\><C-N><C-L>
    " fix readline bindings, until neovim properly handles Alt key
    tnoremap <M-f> <Esc>f
    tnoremap <M-b> <Esc>b
    tnoremap <M-d> <Esc>d
    tnoremap <M-.> <Esc>.
    tnoremap <M-BS> <Esc><BS>
    tnoremap <silent> <C-[> <C-\><C-N>:echo <Bar> call search('\S', 'bcW')<CR>0

    nnoremap <silent> she :terminal<CR>
    nnoremap <silent> shs :split \| terminal<CR>
    nnoremap <silent> shv :vsplit \| terminal<CR>
    nnoremap <silent> sht :-tabnew +terminal<CR>
    augroup terminal
        autocmd!
        autocmd BufEnter * if &buftype ==# "terminal" | call feedkeys("i", "nt") | endif
        autocmd BufLeave * if &buftype ==# "terminal" | redraw | echo | endif
    augroup END
else
    nnoremap <silent> she :echoerr "You're inside an instance of Vim, not Neovim!"<CR>
    nnoremap <silent> shs :echoerr "You're inside an instance of Vim, not Neovim!"<CR>
    nnoremap <silent> shv :echoerr "You're inside an instance of Vim, not Neovim!"<CR>
    nnoremap <silent> sht :echoerr "You're inside an instance of Vim, not Neovim!"<CR>
endif


" ======================================================================
" Functions
" ======================================================================

" ----------------------------------------------------------------------
" Tmux Navigation
" ----------------------------------------------------------------------
function! s:TmuxSwitchWindows(direction)
    let old_win = winnr()
    execute "wincmd ".a:direction
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
        set filetype=markdown
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        setlocal buflisted
    endif
endfunction

nnoremap <silent> zs :silent call <SID>Scratch()<CR>
command! -nargs=1 -complete=dir -bang Keep setlocal buftype= | saveas<bang> <args>

" ----------------------------------------------------------------------
" BufKill
" ----------------------------------------------------------------------
function! s:BufKill(kill_command)
    let buf_to_kill = bufnr("%")
    let orig_win = winnr()
    let orig_tab = tabpagenr()
    for i in range(tabpagenr("$"))
        execute "noautocmd tabnext " . (i + 1)
        while bufwinnr(buf_to_kill) != -1
            execute "noautocmd" bufwinnr(buf_to_kill) "wincmd w"
            execute bufname("%") ==# bufname("#") ? "wincmd q" : "buffer #"
        endwhile
    endfor
    execute "noautocmd tabnext" orig_tab
    execute "noautocmd" orig_win "wincmd w"
    execute "silent!" a:kill_command buf_to_kill
endfunction

nnoremap <silent> <Leader>bd :call <SID>BufKill("bdelete!")<CR>
nnoremap <silent> <Leader>bw :call <SID>BufKill("bwipe!")<CR>

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
    let todo = 'TODO|FIXME|XXX'
    let todo_tagged = join(map(split(todo, '|'), "v:val.' '.'".todo_tag."'"), '|')
    let todo_str = a:include_tag ? todo_tagged : todo
    execute printf("Ag '%s' %s", todo_str, todo_dir)
endfunction

let g:todo_tag = "[PGD]"
command! -nargs=? -bang -complete=dir TodoList call <SID>TodoList(<bang>1, <q-args>)

nnoremap <Leader>td O<Esc>ccTODO <C-R>=g:todo_tag<CR><Esc>:normal gcc<CR>==0f]a<Space>
nnoremap <Leader>fm O<Esc>ccFIXME <C-R>=g:todo_tag<CR><Esc>:normal gcc<CR>==0f]a<Space>
nnoremap <Leader>xx O<Esc>ccXXX <C-R>=g:todo_tag<CR><Esc>:normal gcc<CR>==0f]a<Space>

" ----------------------------------------------------------------------
" Ag
" ----------------------------------------------------------------------
function! s:Ag(use_loclist, args)
    let save_errorformat = &g:errorformat
    let ag_args = (empty(a:args) ? printf('"\b%s\b"', expand("<cword>")) : a:args)
    let ag_cmd = printf('ag --vimgrep --follow --smart-case %s 2>/dev/null', ag_args)
    let ag_output = system(ag_cmd)
    let &g:errorformat = '%f:%l:%c:%m,%f'
    if a:use_loclist
        silent! lgetexpr ag_output | lopen
    else
        silent! cgetexpr ag_output | copen
    endif
    let &g:errorformat = save_errorformat
endfunction

command! -nargs=* -complete=file Ag call <SID>Ag(0, <q-args>)
command! -nargs=* -complete=file AgAdd call <SID>Ag(0, <q-args>)
command! -nargs=* -complete=file LAg call <SID>Ag(1, <q-args>)
command! -nargs=* -complete=file LAgAdd call <SID>Ag(1, <q-args>)

nnoremap ga :Ag<CR>

" ----------------------------------------------------------------------
" CToggle
" ----------------------------------------------------------------------
function! s:Ctoggle()
    let window_count = winnr("$")
    cclose
    if window_count == winnr("$")
        copen
    endif
endfunction

nnoremap <silent> coq :call <SID>Ctoggle()<CR>

" ----------------------------------------------------------------------
" Syntax Names
" ----------------------------------------------------------------------
" Stolen from scriptease.vim
function! s:syntax_groups(count)
    let syntax_names = uniq(reverse(map(synstack(line("."), col(".")), 'synIDattr(v:val, "name")')))
    if a:count
        let name = get(syntax_names, a:count - 1, "")
        if name !=# ""
            execute "syntax list" name
        endif
    else
        echo join(syntax_names, " ")
    endif
endfunction

nnoremap <silent> <C-S> :<C-U>call <SID>syntax_groups(v:count)<CR>

" ----------------------------------------------------------------------
" Vim Eval
" ----------------------------------------------------------------------
" Stolen from scriptease.vim
function! s:vim_eval(type)
    let reg_save = @@
    let clipboad_save = &clipboard
    let selection_save = &selection
    try
        set selection=inclusive clipboard=
        if a:type ==# "char"
            execute "normal! `[v`]y"
        elseif a:type ==# "line"
            execute "normal! '[V']y"
        else
            execute "normal! gvy"
        endif
        let @@ = matchstr(@@, '^\_s\+') . string(eval(substitute(@@, '\n\%(\s*\\\)\?', '', 'g')))
        normal! gvp
    catch /^.*/
        echohl ErrorMsg | echo "Error in evaling expression:" @@ | echo v:exception | echohl NONE
    finally
        let @@ = reg_save
        let &clipboard = clipboad_save
        let &selection = selection_save
    endtry
endfunction

nnoremap <silent> g!p :copy . <Bar> execute "normal g!!" <Bar> execute "normal! I=> "  <Bar> -join <Bar> silent! call repeat#set("g!p", 1)<CR>
nnoremap <silent> g! :<C-U>set opfunc=<SID>vim_eval<CR>g@
nnoremap <silent> g!! :<C-U>set opfunc=<SID>vim_eval<CR>g@_
xnoremap <silent> g! :<C-U>call <SID>vim_eval(visualmode())<CR>

" ----------------------------------------------------------------------
" Refresh Filetype Settings
" ----------------------------------------------------------------------
command! -nargs=1 RefreshFiletypeSettings
            \ bufdo if &ft ==# '<args>' | set ft=text | set ft=<args> | endif


" ======================================================================
" Plugins
" ======================================================================

" ----------------------------------------------------------------------
" Matchit
" ----------------------------------------------------------------------
runtime! macros/matchit.vim

" ----------------------------------------------------------------------
" Niffler Settings
" ----------------------------------------------------------------------
let g:niffler_user_command = 'ag %s -g ""'
let g:niffler_ignore_extensions = [".class", ".backup"]
let g:niffler_ignore_dirs = ["Library", "Applications", "Downloads", "1Password"]

nnoremap <silent> snf :Niffler<CR>
nnoremap <silent> snh :Niffler %:h<CR>
nnoremap <silent> sng :Niffler -vcs<CR>
nnoremap <silent> snm :NifflerMRU<CR>
nnoremap <silent> snb :NifflerBuffer<CR>
nnoremap <silent> snT :NifflerTags<CR>
nnoremap <silent> snt :NifflerTags %<CR>

nnoremap <silent> g] :NifflerTselect<CR>
nnoremap <silent> g<C-]> :NifflerTjump<CR>

" ----------------------------------------------------------------------
" Rainbow Parentheses Settings
" ----------------------------------------------------------------------
augroup rainbow
    autocmd!
    autocmd FileType clojure,html,javascript RainbowParentheses
augroup END

" ----------------------------------------------------------------------
" Signify Settings
" ----------------------------------------------------------------------
let g:signify_vcs_list = ['git', 'svn']
omap ic <Plug>(signify-motion-inner-pending)
xmap ic <Plug>(signify-motion-inner-visual)

" ----------------------------------------------------------------------
" Fugitive Settings
" ----------------------------------------------------------------------
nnoremap cd :Gcd<CR>:pwd<CR>

" do git ...
nnoremap <silent> dgb :Gblame<CR>
nnoremap <silent> dgs :Gstatus <Bar> wincmd J<CR>
nnoremap <silent> dgd :Gvdiff<CR>
nnoremap <silent> dgc :Gcommit<CR>
nnoremap <silent> dgC :Git! diff --cached<CR>:Gcommit<CR>
nnoremap <silent> dga :Gwrite<CR>
nnoremap <silent> dgr :Gread<CR>
nnoremap <silent> dgp :Git push origin master<CR>
nnoremap <silent> dgh :Git push heroku master<CR>

" see git ...
nnoremap <silent> sgl :Glog<CR>
nnoremap <silent> sgb :Git! branch<CR>
nnoremap <silent> sgd :Git! diff<CR>
nnoremap <silent> sgc :Git! diff --cached<CR>
nnoremap <silent> sgh :Git! show HEAD --format=short<CR>

" ----------------------------------------------------------------------
" GV
" ----------------------------------------------------------------------
nnoremap <silent> dgv :GV -n500<CR>
nnoremap <silent> dgf :GV! -n500<CR>

" ----------------------------------------------------------------------
" Unimpaired Settings
" ----------------------------------------------------------------------
function! s:UnimpairedMappings()
    nnoremap <silent> cou :call <SID>ColorColumnToggle()<CR>
endfunction

" ----------------------------------------------------------------------
" Vim-Easy-Align
" ----------------------------------------------------------------------
nmap <Leader>ea <Plug>(EasyAlign)
xmap <Leader>ea <Plug>(EasyAlign)

" ----------------------------------------------------------------------
" Dirvish
" ----------------------------------------------------------------------
let g:loaded_netrwPlugin = 1
nnoremap <silent> - :Dirvish %:p:h<CR>

 " ----------------------------------------------------------------------
" Sparkup
" ----------------------------------------------------------------------
let g:sparkupExecuteMapping = '<C-H>'
let g:sparkupNextMapping = '<C-J>'

" ----------------------------------------------------------------------
" Markdown Settings
" ----------------------------------------------------------------------
let g:markdown_fenced_languages = ["vim","python","clojure","javascript","bash=sh"]

" ----------------------------------------------------------------------
" Dash
" ----------------------------------------------------------------------
nmap K <Plug>DashSearch

" ----------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------
nnoremap <Leader>tt :TagbarToggle<CR>

" ----------------------------------------------------------------------
" Endwise
" ----------------------------------------------------------------------
let g:endwise_no_mappings = 1
inoremap <CR> <CR><C-R>=<SID>AutocloseBraces()<CR>

function! s:AutocloseBraces()
    let prev_line = getline(line(".") - 1)
    if prev_line =~# '{$'
        return "}\<C-O>O"
    else
        call feedkeys("\<Plug>DiscretionaryEnd", "m")
        return ""
    endif
endfunction

" ----------------------------------------------------------------------
" Protean
" ----------------------------------------------------------------------
nmap sf <Plug>Protean-Finish
nmap sp <Plug>Protean-Replace
xmap sp <Plug>Protean-Replace

" ----------------------------------------------------------------------
" Accio
" ----------------------------------------------------------------------
let g:accio_create_empty_quickfix = 0
let g:accio_update_interval = 250

" ----------------------------------------------------------------------
" SplitJoin
" ----------------------------------------------------------------------
let g:splitjoin_split_mapping = "sj"
let g:splitjoin_join_mapping = "sk"

" ----------------------------------------------------------------------
" Switch.vim
" ----------------------------------------------------------------------
let g:switch_mapping = "<CR>"
let g:switch_custom_definitions =
    \ [
    \   ['!=', '=='],
    \   {
    \       '!(\([^(&|)]\+\|([^()]\+)\) && \([^(&|)]\+\|([^()]\+)\))': '!\1 || !\2',
    \       '!(\([^(&|)]\+\|([^()]\+)\) || \([^(&|)]\+\|([^()]\+)\))': '!\1 && !\2'
    \   }
    \ ]

" ----------------------------------------------------------------------
" Ultisnips
" ----------------------------------------------------------------------
let g:UltiSnipsSnippetsDir = '$XDG_CONFIG_HOME/nvim/ultisnips'
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" ======================================================================
" Autocmds
" ======================================================================

augroup vimrc
    autocmd!
    " Jump to the last position when reopening a file
    autocmd BufReadPost * if &filetype != "gitcommit" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.{hbs,handlebars} set filetype=html
    autocmd Filetype pandoc,markdown setlocal spell
    autocmd SourceCmd *unimpaired.vim source <afile> | call <SID>UnimpairedMappings()
    autocmd WinEnter,BufWinEnter * if !(&diff) | silent set cursorline | redraw | endif
    autocmd WinLeave,BufWinLeave * silent set nocursorline
augroup END

augroup vimenter
    autocmd!
    autocmd VimEnter * silent setlocal cursorline
augroup END

augroup cmdwin
    autocmd!
    autocmd CmdWinEnter * noremap <buffer> <CR> <CR>
    autocmd CmdWinEnter * noremap! <buffer> <CR> <CR>
augroup END

augroup qf
    autocmd!
    autocmd QuickFixCmdPost grep,make,grepadd,vimgrep,vimgrepadd,cscope,cfile,cgetfile,caddfile,helpgrep cwindow
    autocmd QuickFixCmdPost lgrep,lmake,lgrepadd,lvimgrep,lvimgrepadd,lcscope,lfile,lgetfile,laddfile lwindow
augroup END

" ----------------------------------------------------------------------
" Colorscheme Settings
" ----------------------------------------------------------------------
nnoremap go :colorscheme gotham<CR>
nnoremap cy :colorscheme yin<CR>

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

" ----------------------------------------------------------------------
" Background Settings
" ----------------------------------------------------------------------
if has('vim_starting')
    let hour = exists("*strftime") ? str2nr(strftime("%H")) : 0
    let yinyang = (hour > 5 && hour < 17) ? "yang" : "yin"
    execute "colorscheme" yinyang
endif

if filereadable(expand('$HOME/.vimrc.local'))
    source $HOME/.vimrc.local
endif
