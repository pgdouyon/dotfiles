let s:save_cpo = &cpoptions
set cpoptions&vim

let g:java_highlight_all = 1

nnoremap <silent><buffer> R :<C-U>call repl#start_repl("groovysh", "groovysh", "groovy")<CR>

" struts
nnoremap <silent><buffer> S :Ripgrep -txml "\b<C-R><C-W>\b"<CR>

function! s:jump_to_toplevel_decl(direction)
    let flags = a:direction . 'sW'
    call search('\C \<\%(class\|enum\|interface\)\> \+\zs', flags)
endfunction

nnoremap <silent><buffer> [[ :call <SID>jump_to_toplevel_decl('b')<CR>
nnoremap <silent><buffer> ]] :call <SID>jump_to_toplevel_decl('')<CR>

function! s:sort_imports()
    let save_cursor = getpos(".")
    call cursor(1, 0)
    let import_start = search("^import", 'cW')
    while import_start
        let import_end = search('^\%(import\)\@!', 'W')
        execute 'keepjumps' import_start ',' (import_end - 1) 'sort r /.*\ze;/'
        let import_start = search("^import", 'W')
    endwhile
    call setpos(".", save_cursor)
endfunction

function! s:parse_expression(start, end, process_function)
    let parser = sj#argparser#common#Construct(a:start, a:end, getline("."))
    call extend(parser, {'Process': function(a:process_function)})
    call parser.Process()
    return parser.args
endfunction

function! s:process_boolean_expression() dict
    while !self.Finished()
        let c = self.body[0]
        let operator = self.body[0:1]
        if operator ==# "&&" || operator ==# "||"
            call self.PushArg()
            call self.PushChar()
            call self.PushChar()
            call self.PushArg()
            continue
        elseif c =~ '["''{\[(\]'
            call self.JumpPair("\"'{[(/", "\"'}])/")
        endif
        call self.PushChar()
    endwhile
    if len(self.current_arg) > 0
        call self.PushArg()
    endif
endfunction

function! s:process_java_expression() dict
    while !self.Finished()
        if self.body[0] == ","
            call self.PushArg()
            call self.Next()
            continue
        elseif self.body[0] =~# "[\"'<{\[(\]"
            call self.JumpPair("\"'<{[(/", "\"'>}])/")
        endif
        call self.PushChar()
    endwhile
    if len(self.current_arg) > 0
        call self.PushArg()
    endif
endfunction

function! s:split_ternary_expr()
    let [match_start, match_end] = sj#SearchposUnderCursor('?.\{-\}:', '', sj#SkipSyntax('javaString'))
    if match_start <= 0
        return 0
    endif
    let line = getline(".")
    let start = sj#GetCols(0, match_start - 1)
    let middle = sj#GetCols(match_start, match_end - 2)
    let end = sj#GetCols(match_end - 1, col("$"))
    let text_list = [sj#Rtrim(start), sj#Trim(middle), sj#Trim(end)]

    let original_visual_start = getpos("'<")
    let original_visual_end = getpos("'>")
    call sj#ReplaceMotion("V", join(text_list, "\n"))
    call setpos("'<", original_visual_start)
    call setpos("'>", original_visual_end)
    return 1
endfunction

function! s:join_ternary_expr()
    if (getline(".") !~# '^\s*?') && (getline(".") !~# '^\s*:')
        return 0
    endif
    let k_count = (getline(".") =~# '^\s*?') ? 1 : 2
    execute "normal!" k_count . "k3J"
    return 1
endfunction

function! s:split_boolean_exprs()
    if sj#SearchUnderCursor('\%(if\|else\)\s*\zs(.\{-\})\s*{') <= 0
        return 0
    endif

    let original_visual_start = getpos("'<")
    let original_visual_end = getpos("'>")
    let [start, end] = sj#LocateBracesOnLine('(', ')', 'javaString')
    let args = s:parse_expression(start + 1, end - 1, 's:process_boolean_expression')
    let split_args = [args[0]]
    for i in range(1, len(args[1:]), 2)
        call add(split_args, join(args[i:i+1]))
    endfor
    call sj#ReplaceMotion("vib", join(split_args, "\n"))
    call setpos("'<", original_visual_start)
    call setpos("'>", original_visual_end)
    return 1
endfunction

function! s:join_boolean_exprs()
    if (getline(".") !~# '^\s*\%(||\|&&\)') && getline(line(".") + 1) !~# '^\s*\%(||\|&&\)'
        return 0
    endif

    let original_visual_start = getpos("'<")
    let original_visual_end = getpos("'>")
    let body = sj#GetMotion("vib")
    let lines = sj#TrimList(split(body, "\n"))
    let joined_text = join(map(lines, 'substitute(v:val, ''\s*\n\s*'', "", "g")'), " ")
    call sj#ReplaceMotion("vab", '('.joined_text.')')
    call setpos("'<", original_visual_start)
    call setpos("'>", original_visual_end)
    return 1
endfunction

function! s:split_args()
    let char = getline(".")[col(".") - 1]
    if char !~# '(\|)'
        normal %
    endif
    if sj#SearchUnderCursor('(.\{-\})', 'n') <= 0
        return 0
    endif

    let original_visual_start = getpos("'<")
    let original_visual_end = getpos("'>")
    let [start, end] = sj#LocateBracesOnLine('(', ')', 'javaString')
    let args = s:parse_expression(start + 1, end - 1, 's:process_java_expression')
    call sj#ReplaceMotion("vib", join(args, ",\n"))
    call setpos("'<", original_visual_start)
    call setpos("'>", original_visual_end)
    return 1
endfunction

function! s:join_args()
    let original_visual_start = getpos("'<")
    let original_visual_end = getpos("'>")
    let body = sj#GetMotion("vib")
    let lines = sj#TrimList(split(body, ",\\s*\n"))
    let joined_text = join(map(lines, 'substitute(v:val, ''\s*\n\s*'', "", "g")'), ", ")
    call sj#ReplaceMotion("vab", '('.joined_text.')')
    call setpos("'<", original_visual_start)
    call setpos("'>", original_visual_end)
    return 1
endfunction

function! s:SID()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID$')
endfunction

let b:splitjoin_split_callbacks = map(["split_ternary_expr", "split_boolean_exprs", "split_args"], 's:SID() . v:val')
let b:splitjoin_join_callbacks = map(["join_ternary_expr", "join_boolean_exprs", "join_args"], 's:SID() . v:val')

command! -nargs=0 -buffer SortImports call <SID>sort_imports()
command! -nargs=0 -buffer IntellijOpen silent !idea %
command! -nargs=0 -buffer Implements Ag --java '\bimplements\b[^{]*\b%:t:r\b'
command! -nargs=0 -buffer Extends Ag --java '\bextends\b[^{]*\b%:t:r\b'
command! -nargs=0 -buffer Override normal {o@Override
command! -nargs=0 -buffer Deprecated normal {o@Deprecated

augroup java_ftplugin
    autocmd BufWritePost <buffer> Accio 'javac'
augroup END


let &cpoptions = s:save_cpo
unlet s:save_cpo
