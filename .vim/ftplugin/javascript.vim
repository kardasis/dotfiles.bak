nnoremap <buffer> <leader>/ I//<space><esc>
setlocal foldmethod=syntax
setlocal foldlevel=3

" Snippets {{{
nnoremap <leader>cl oconsole.log()<esc>i
nnoremap <leader>ce oconsole.error()<esc>i

" take the word under the cursor and console log it as an object
nnoremap <leader>cL :execute "normal! oconsole.log({ " . expand('<cword>') . " })"<cr>
" }}}
