:let dburl = $DB_URL

nnoremap <leader>r :execute "%DB " . dburl<cr>
vnoremap <leader>r :<C-u>execute "'<,'>DB " . dburl<cr>

