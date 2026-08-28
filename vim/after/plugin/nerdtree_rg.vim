" --- Directory-scoped ripgrep from NERDTree ---

" function! NERDTreeRgSearch() abort
"   let l:node = g:NERDTreeFileNode.GetSelected()
"   if empty(l:node)
"     return
"   endif
"
"   " Folder the cursor is over, or the folder containing the file under cursor
"   let l:p = l:node.path
"   let l:dir = l:p.isDirectory ? l:p.str() : fnamemodify(l:p.str(), ':h')
"
"   let l:term = input('Rg in ' . fnamemodify(l:dir, ':~') . ': ')
"   if empty(l:term)
"     redraw!
"     return
"   endif
"
"   call fzf#vim#grep(
"     \ 'rg --column --line-number --no-heading --color=always --smart-case -- '
"     \   . shellescape(l:term) . ' ' . shellescape(l:dir),
"     \ 1,
"     \ fzf#vim#with_preview(),
"     \ 0)
" endfunction


function! NERDTreeRgPrompt() abort
  let l:node = g:NERDTreeFileNode.GetSelected()
  if empty(l:node)
    return
  endif

  let l:p = l:node.path
  let l:dir = l:p.isDirectory ? l:p.str() : fnamemodify(l:p.str(), ':h')

  " Path relative to cwd, e.g. 'client-games' or '.claude/skills'
  let l:rel = fnamemodify(l:dir, ':.')

  " Hidden top-level folder (leading dot) → rg skips it unless --hidden
  let l:hidden = l:rel =~# '^\.' ? '--hidden ' : ''

  call feedkeys(":Rg " . l:hidden . "--glob='" . l:rel . "/**' ", 'n')
endfunction

call NERDTreeAddMenuItem({
  \ 'text': '(r)ipgrep search in dir',
  \ 'shortcut': 'r',
  \ 'callback': 'NERDTreeRgPrompt' })


augroup nerdtree_rg
  autocmd!
  autocmd FileType nerdtree nnoremap <buffer> <silent> gr :call NERDTreeRgPrompt()<CR>
augroup END
