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
Plug 'pgdouyon/vim-alayas'
Plug 'pgdouyon/vim-orgflowy', {'dir': '~/projects/vim-orgflowy'}

" Tim Pope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'

" Editing Enhancements
Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'

" Text Objects
Plug 'michaeljsmith/vim-indent-object'

" Appearance
Plug 'romainl/Apprentice'

" Tool Integration
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'
Plug 'editorconfig/editorconfig-vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'rizzatti/dash.vim', {'on': ['Dash', '<Plug>DashSearch']}

" Languages
Plug 'tpope/vim-markdown'
Plug 'rstacruz/sparkup', {'rtp': 'vim'}
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-salve', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml', 'ftl']}

if filereadable(expand('$HOME/.plug.local.vim'))
    source $HOME/.plug.local.vim
endif

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

" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase
set define=^\\s*.\\{-\\}\\ze\\i\\+\\s\\+==\\@!
if exists("&inccommand")
    set inccommand=nosplit
endif

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
set laststatus=1
set statusline=%!statusline#schmexy_statusline()
set splitbelow
set splitright

" Multiple Tab Pages
set showtabline=1
set tabline=%!statusline#schmexy_tabline()

" Terminal
set ttyfast

" Mouse
set mouse=""

" GUI
set guioptions="cegmt"
set termguicolors
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait700-blinkoff100-blinkon999-Cursor/lCursor
if !has("nvim") && !empty($TMUX)
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Messages
set shortmess+=A
set noshowcmd
set ruler
let &rulerformat=statusline#schmexy_rulerformat()

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
set diffexpr=EnhancedDiff#Diff('git\ diff',\ '--diff-algorithm=histogram')

" Mapping
set ttimeout
set ttimeoutlen=10

" Reading/Writing Files
set autoread

" Swap Files
set noswapfile

" Command Line Editing
set wildmenu
set wildignorecase
set wildmode=longest,full
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
nnoremap <silent> <Left> :vertical resize -5<CR>
nnoremap <silent> <Right> :vertical resize +5<CR>
nnoremap <silent> <Down> :resize -5<CR>
nnoremap <silent> <Up> :resize +5<CR>

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

inoremap <expr> <C-E> pumvisible() ? "\<C-E>" : "\<End>"

" ----------------------------------------------------------------------
" Command Line
" ----------------------------------------------------------------------
" write file with super user privileges
" cabbrev w!! w !sudo tee % > /dev/null

cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap %<C-H> <C-R>=expand("%:h")<CR>

" ----------------------------------------------------------------------
" Terminal
" ----------------------------------------------------------------------
if exists(":terminal")
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
    tnoremap <silent> <C-[> <C-\><C-N>:echo<CR>
    tnoremap <silent> <C-Q> <C-\><C-N>:<C-U>close<CR>

    nnoremap <silent> she :terminal<CR>
    nnoremap <silent> shs :split \| terminal<CR>
    nnoremap <silent> shv :vsplit \| terminal<CR>
    nnoremap <silent> sht :-tabnew +terminal<CR>
    augroup terminal
        autocmd!
        autocmd BufLeave * if &buftype ==# "terminal" | echo | endif
        if exists("##TermOpen")
            autocmd TermOpen * setlocal bufhidden=hide
            autocmd TermOpen * nnoremap <silent><buffer> <C-Q> :<C-U>close<CR>
        endif
        if exists("##TermClose")
            autocmd TermClose * call feedkeys("\<CR>")
        endif
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

function! s:synnames()
    call string(reverse(map(synstack(line('.'), col('.')), 'execute("hi ".synIDattr(v:val, "name"), "")')))
endfunction
nnoremap <silent> <C-S> :call <SID>synnames()<CR>

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
    let is_enabled = !get(w:, "enableColorcolumn", 0)
    call s:SetColorColumn(is_enabled)
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
        command! -buffer -nargs=1 -complete=dir -bang Keep setlocal buftype= | saveas<bang> <args>
    endif
endfunction

nnoremap <silent> zs :silent call <SID>Scratch()<CR>

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

    let todo_tag = escape('[PGD]', '()[]{}<>!@#$%^&*-_+=\|?.')
    let todo_regex = '(TODO|FIXME|XXX)'
    let todo_tag_regex = join([todo_regex, todo_tag], ' ')
    let todo_str = a:include_tag ? todo_tag_regex : todo_regex
    execute printf("Ripgrep '%s' %s", todo_str, todo_dir)
endfunction

command! -nargs=? -bang -complete=dir TodoList call <SID>TodoList(<bang>1, <q-args>)

nnoremap <Leader>td :<C-U>put! ='TODO [PGD]'<Bar>normal gcc==<CR>0f]a<Space>
nnoremap <Leader>fm :<C-U>put! ='FIXME [PGD]'<Bar>normal gcc==<CR>0f]a<Space>
nnoremap <Leader>xx :<C-U>put! ='XXX [PGD]'<Bar>normal gcc==<CR>0f]a<Space>

" ----------------------------------------------------------------------
" Ripgrep
" ----------------------------------------------------------------------
if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m,%f:%l:%m,%f
endif

function! s:get_visual_selection()
    let selection_save = &selection
    let unnamed_save = @@
    let yank_save = @0
    set selection=inclusive
    normal! gvy
    let visual_selection = @@
    let @0 = yank_save
    let @@ = unnamed_save
    let &selection = selection_save
    return visual_selection
endfunction

function! s:search(args, ...)
    let flags = a:0 ? a:1 : ''
    execute "silent grep! -F" flags shellescape(escape(a:args, '|#%'))
endfunction

function! s:ripgrep(args)
    execute "silent grep!" escape(a:args, '|#%')
endfunction

function! s:ag(args)
    let save_grepprg = &grepprg
    set grepprg=ag\ --vimgrep\ --smart-case\ -W500\ $*
    execute "silent grep!" escape(a:args, '|#%')
    let &grepprg = save_grepprg
endfunction

command! -nargs=+ -complete=tag Search call <SID>search(<q-args>)
command! -nargs=+ -complete=file Ripgrep call <SID>ripgrep(<q-args>)
command! -nargs=+ -complete=file Ag call <SID>ag(<q-args>)
nnoremap <silent> <Plug>GrepOperator :<C-U>call <SID>search(expand('<cword>'), '-w')<CR>
xnoremap <silent> <Plug>GrepOperator :<C-U>call <SID>search(<SID>get_visual_selection())<CR>

nmap <silent> gr <Plug>GrepOperator
xmap <silent> gr <Plug>GrepOperator

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
" Filetype Detect
" ----------------------------------------------------------------------
command! -nargs=1 FiletypeDetect bufdo if &ft ==# '<args>' | filetype detect | endif

" ----------------------------------------------------------------------
" Changelist Jump
" ----------------------------------------------------------------------
function! s:changelist_jump(forward)
    let cmd = a:forward ? "g;" : "g,"
    let cursor_position = getpos(".")
    try
        execute "normal!" v:count1 . cmd
        if cursor_position == getpos(".")
            execute "normal!" v:count1 . cmd
        endif
    catch
        echohl ErrorMsg | echo substitute(v:exception, '^[^:]*:', '', '') | echohl None
    endtry
endfunction

nnoremap <silent> g; :<C-U>call <SID>changelist_jump(1)<CR>
nnoremap <silent> g, :<C-U>call <SID>changelist_jump(0)<CR>

" ----------------------------------------------------------------------
" Eval Expression
" ----------------------------------------------------------------------
function! s:eval()
    let expression = input(":= ", "", "expression")
    redraw
    try
        if !empty(expression)
            echo eval(expression)
        endif
    catch
        let error_message = substitute(v:exception, '^Vim[^:]*:', '', '')
        echohl WarningMsg | echo error_message | echohl None
    endtry
endfunction

nnoremap g= :<C-U>call <SID>eval()<CR>


" ======================================================================
" Plugins
" ======================================================================

" ----------------------------------------------------------------------
" Matchit
" ----------------------------------------------------------------------
runtime! macros/matchit.vim

" ----------------------------------------------------------------------
" 2HTML
" ----------------------------------------------------------------------
let g:loaded_2html_plugin = 0

" ----------------------------------------------------------------------
" Niffler Settings
" ----------------------------------------------------------------------
let g:niffler_tag_mappings = 1
let g:niffler_user_command = 'rg --files %s'
let g:niffler_ignore_extensions = [".class", ".backup"]
let g:niffler_ignore_dirs = ["Library", "Applications", "Downloads", "1Password"]

nnoremap <silent> snf :Niffler<CR>
nnoremap <silent> snh :Niffler %:h<CR>
nnoremap <silent> sng :Niffler -vcs<CR>
nnoremap <silent> snm :NifflerMRU<CR>
nnoremap <silent> snb :NifflerBuffer<CR>
nnoremap <silent> snT :NifflerTags<CR>
nnoremap <silent> snt :NifflerTags %<CR>

command! -nargs=0 -bang NifflerOrgFlowy call niffler#custom({'source': function('orgflowy#completion_candidates_list'), 'sink': 'OrgFlowy'})
nnoremap <silent> sno :NifflerOrgFlowy<CR>

" ----------------------------------------------------------------------
" Signify Settings
" ----------------------------------------------------------------------
let g:signify_vcs_list = ['git', 'svn']
omap ic <Plug>(signify-motion-inner-pending)
xmap ic <Plug>(signify-motion-inner-visual)

" ----------------------------------------------------------------------
" Fugitive Settings
" ----------------------------------------------------------------------
let g:fugitive_dynamic_colors = 0

nnoremap cd :Gcd<CR>:pwd<CR>

" do git ...
nnoremap <silent> dgb :Git blame<CR>
nnoremap <silent> dgs :Git <Bar> wincmd J<CR>
nnoremap <silent> dgd :Gvdiffsplit<CR>
nnoremap <silent> dgC :tab split<Bar>Git diff --cached<CR>:Git commit<CR>
nnoremap <silent> dga :Gwrite<CR>
nnoremap <silent> dgr :Gread<CR>
nnoremap <silent> dgp :Git push origin master<CR>

" see git ...
nnoremap <silent> sgl :Git log<CR>
nnoremap <silent> sgb :Git branch<CR>
nnoremap <silent> sgd :0Git diff<CR>
nnoremap <silent> sgc :0Git diff --cached<CR>
nnoremap <silent> sgh :0Git show HEAD --format=short<CR>

augroup fugitive_vimrc
    autocmd!
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
augroup END

" ----------------------------------------------------------------------
" GV
" ----------------------------------------------------------------------
nnoremap <silent> dgv :GV -n500<CR>
nnoremap <silent> dgf :GV! -n500<CR>

" ----------------------------------------------------------------------
" Unimpaired Settings
" ----------------------------------------------------------------------
nmap co <Plug>(unimpaired-toggle)

function! s:UnimpairedMappings()
    nnoremap <silent> cou :call <SID>ColorColumnToggle()<CR>
endfunction

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

" ----------------------------------------------------------------------
" Switch.vim
" ----------------------------------------------------------------------
let g:switch_mapping = "<CR>"
let g:switch_custom_definitions =
    \ [
    \   ['!=', '=='],
    \   ['public', 'private', 'protected'],
    \   ['extends', 'implements'],
    \   {
    \       '!(\([^(&|)]\+\|([^()]\+)\) && \([^(&|)]\+\|([^()]\+)\))': '!\1 || !\2',
    \       '!(\([^(&|)]\+\|([^()]\+)\) || \([^(&|)]\+\|([^()]\+)\))': '!\1 && !\2'
    \   }
    \ ]

" ----------------------------------------------------------------------
" SplitJoin
" ----------------------------------------------------------------------
let g:splitjoin_split_mapping = 'sj'
let g:splitjoin_join_mapping = 'sk'

" ----------------------------------------------------------------------
" Ultisnips
" ----------------------------------------------------------------------
let g:UltiSnipsSnippetsDir = '$XDG_CONFIG_HOME/nvim/ultisnips'
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" ----------------------------------------------------------------------
" Vim-Sexp
" ----------------------------------------------------------------------
function! s:sexp_mappings()
    for wrap_char in ["b", "(", ")", "r", "[", "]", "B", "{", "}"]
        " vim surround mappings
        execute printf("nmap <buffer><silent> cse%s vieS%s", wrap_char, wrap_char)
    endfor
    nmap <buffer> dsf <Plug>(sexp_splice_list)
    nmap <buffer> <I  <Plug>(sexp_insert_at_list_head)
    nmap <buffer> >I  <Plug>(sexp_insert_at_list_tail)
    nmap <buffer> <f  <Plug>(sexp_swap_list_backward)
    nmap <buffer> >f  <Plug>(sexp_swap_list_forward)
    nmap <buffer> <e  <Plug>(sexp_swap_element_backward)
    nmap <buffer> >e  <Plug>(sexp_swap_element_forward)
    nmap <buffer> >(  <Plug>(sexp_emit_head_element)
    nmap <buffer> <)  <Plug>(sexp_emit_tail_element)
    nmap <buffer> <(  <Plug>(sexp_capture_prev_element)
    nmap <buffer> >)  <Plug>(sexp_capture_next_element)
endfunction

augroup sexp_mappings
    autocmd!
    autocmd FileType clojure call <SID>sexp_mappings()
augroup END

" ----------------------------------------------------------------------
" MatchTagAlways
" ----------------------------------------------------------------------
let g:mta_filetypes = { 'html': 1, 'ftl': 1, 'xml' : 1 }

" ----------------------------------------------------------------------
" EditorConfig
" ----------------------------------------------------------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ----------------------------------------------------------------------
" Gutentags
" ----------------------------------------------------------------------
if executable('rg')
    let g:gutentags_file_list_command = 'rg --files'
else
    let g:gutentags_file_list_command = { 'markers': { '.git': 'git ls-files' } }
endif

" ======================================================================
" Autocmds
" ======================================================================

augroup vimrc
    autocmd!
    " Jump to the last position when reopening a file
    autocmd BufReadPost * if &filetype != "gitcommit" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.{hbs,handlebars} set filetype=html
    autocmd SourceCmd *unimpaired.vim source <afile> | call <SID>UnimpairedMappings()
    autocmd WinEnter * if !(&diff) | silent set cursorline | endif
    autocmd WinLeave * silent set nocursorline
    autocmd VimLeave * set guicursor=a:block-blinkon0
augroup END

augroup vimenter
    autocmd!
    autocmd VimEnter * silent set cursorline
augroup END

augroup cmdwin
    autocmd!
    autocmd CmdWinEnter * noremap <buffer> <CR> <CR>
    autocmd CmdWinEnter * noremap! <buffer> <CR> <CR>
augroup END

function! s:quickfix_cmd_post(list)
    if empty(a:list)
        redraw!
        unsilent call dotfiles#utils#echo_error("No results found")
    endif
endfunction

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost grep,make,grepadd,vimgrep,vimgrepadd,cscope,cfile,cgetfile,caddfile,helpgrep call <SID>quickfix_cmd_post(getqflist())
    autocmd QuickFixCmdPost lgrep,lmake,lgrepadd,lvimgrep,lvimgrepadd,lcscope,lfile,lgetfile,laddfile call <SID>quickfix_cmd_post(getloclist(winnr()))
augroup END

" ----------------------------------------------------------------------
" Colorscheme Settings
" ----------------------------------------------------------------------
nnoremap cyi :colorscheme yin<CR>
nnoremap cya :colorscheme yang<CR>
nnoremap cv :colorscheme vimalayas<CR>

function! s:SetColorColumn(...)
    let configured_filetypes = ['java']
    let is_enabled = a:0 ? a:1 : (index(configured_filetypes, &filetype) > -1)
    if !exists("w:enableColorcolumn")
        let w:enableColorcolumn = 0
    endif
    if w:enableColorcolumn != is_enabled
        let w:enableColorcolumn = is_enabled
        if w:enableColorcolumn
            silent! call matchadd("ColorColumn", '\%>120v.', 0, 954)
            echohl WarningMsg | echo "ColorColumn enabled..." | echohl None
        else
            silent! call matchdelete(954)
            echohl WarningMsg | echo "ColorColumn disabled..." | echohl None
        endif
    endif
endfunction

augroup colorcolumn
    autocmd!
    autocmd FileType * silent call <SID>SetColorColumn()
    autocmd WinEnter * silent call <SID>SetColorColumn()
    autocmd BufWinEnter * silent call <SID>SetColorColumn()
augroup END

" ----------------------------------------------------------------------
" Background Settings
" ----------------------------------------------------------------------
if has('vim_starting')
    let hour = str2nr(strftime("%H"))
    if hour > 7 && hour <= 15
        colorscheme yang
    elseif hour > 15 && hour < 20
        colorscheme vimalayas
    else
        colorscheme yin
    endif
endif

if filereadable(expand('$HOME/.vimrc.local'))
    source $HOME/.vimrc.local
endif
