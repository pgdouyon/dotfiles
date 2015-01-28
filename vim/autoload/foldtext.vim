" ======================================================================
" Foldtext
" ======================================================================
function! foldtext#schmexy_foldtext()
    let foldstart = nextnonblank(v:foldstart)
    if foldstart > v:foldend
        let foldline = getline(v:foldstart)
    else
        let foldline = substitute(getline(foldstart), '\t', repeat(' ', &tabstop), 'g')
    endif

    let winwidth = winwidth(0) - &foldcolumn - (&number ? 4 : 0)
    let padding = repeat(' ', 8)
    let foldsize = 1 + v:foldend - v:foldstart
    let foldSizeText = ' ' . foldsize . ' lines '
    let foldPercentage = printf('[%.1f%%]', ((foldsize * 1.0)/line("$"))*100)
    let expansionString = repeat('.', winwidth - strwidth(foldline.foldSizeText.foldPercentage.padding))
    return foldline . expansionString . foldSizeText . foldPercentage . padding
endfunction
