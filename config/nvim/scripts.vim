" used for filetype detection for shell scripts
" see :h 43.2

if did_filetype()
    finish
endif

let executable = matchstr(getline(1), '#!\s*/usr/bin/env\s*\zs\w\+')
if executable ==# 'bb'
    setfiletype clojure
endif
