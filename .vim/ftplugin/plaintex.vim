
" on save build with pdflatex and preview
  autocmd bufwritepost * :execute "silent !pdflatex -halt-on-error % && open -a Preview $(echo % | sed 's/tex$/pdf/')" 
