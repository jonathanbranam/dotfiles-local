" org.vim -- override some settings
"
setlocal tabstop=2 shiftwidth=2

" Disable some highlights from vim-orgmode
" org_italic is between // and highlights all over code
hi org_italic    term=NONE    cterm=NONE    gui=NONE
" org_code is between == or ~~ and highlights all over code
hi org_code    term=NONE    cterm=NONE    gui=NONE
" org_underline is between pairs of _
hi org_underline    term=NONE    cterm=NONE    gui=NONE


" Why did I have this disabled?
" setl formatoptions-=t
" setl nospell
" set spell
