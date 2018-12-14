setlocal foldmethod=indent
setlocal foldnestmax=10 
setlocal nofoldenable
setlocal foldlevel=2

  " format json
nnoremap <leader>jq :%!jq '.'<cr>
