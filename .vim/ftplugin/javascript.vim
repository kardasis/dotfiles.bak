setlocal foldmethod=syntax
setlocal foldlevel=8

" Logging {{{
nnoremap <leader>ll oconsole.log()<esc>i
nnoremap <leader>le oconsole.error()<esc>i

" take the word under the cursor and console log it as an object
nnoremap <leader>lL :execute "normal! oconsole.log({ " . expand('<cword>') . " })"<cr>
nnoremap <leader>lE :execute "normal! oconsole.error({ " . expand('<cword>') . " })"<cr>
nnoremap <leader>lq :execute "normal! oconsole.log(' " . expand('<cword>') . " ')"<cr>
" }}}
