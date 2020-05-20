nnoremap <buffer> <leader>r :call Run()<cr>
function! Run()
  if filereadable(expand("./Pipfile"))
    :execute '!pipenv run python' shellescape(@%, 1)
  else
    :execute '!python' shellescape(@%, 1)
  endif
endfunction

set foldmethod=indent 
setlocal foldlevel=8
