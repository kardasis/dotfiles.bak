function! MarkdownLevel()
  if getline(v:lnum) =~ '^# .*$'
      return ">1"
  endif
  if getline(v:lnum) =~ '^## .*$'
      return ">2"
  endif
  if getline(v:lnum) =~ '^### .*$'
      return ">3"
  endif
  if getline(v:lnum) =~ '^#### .*$'
      return ">4"
  endif
  if getline(v:lnum) =~ '^##### .*$'
      return ">5"
  endif
  if getline(v:lnum) =~ '^###### .*$'
      return ">6"
  endif
  return "=" 
endfunction

setlocal foldexpr=MarkdownLevel()  
setlocal foldmethod=expr  
onoremap ih :<c-u>execute "normal! ?^\\(==\\+\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>

" alway preview markdown files on save
 autocmd bufwritepost *.md :execute "call Vim_Markdown_Preview()"
