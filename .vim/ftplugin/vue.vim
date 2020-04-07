autocmd FileType vue syntax sync fromstart 

nnoremap <leader>ssf :syntax sync fromstart<cr>

setlocal foldmethod=syntax
setlocal foldlevel=8

" Logging {{{
nnoremap <leader>ll othis.log()<esc>i
nnoremap <leader>le othis.logError()<esc>i
nnoremap <leader>ld othis.debug()<esc>i

" log the word under the cursor
nnoremap <leader>lL :execute "normal! othis.log({ " . expand('<cword>') . " })"<cr>
nnoremap <leader>lE :execute "normal! othis.logError({ " . expand('<cword>') . " })"<cr>
nnoremap <leader>lD :execute "normal! othis.debug({ " . expand('<cword>') . " })"<cr>
nnoremap <leader>lq :execute "normal! othis.debug(' " . expand('<cword>') . " ')"<cr>
" }}}
