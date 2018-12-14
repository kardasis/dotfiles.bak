" Author : Ari Kardasis
" ari.kardasis@gmail.com

set nocompatible


" PLUGINGS {{{
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
Plugin 'pedrohdz/vim-yaml-folds'
Plugin 'plytophogy/vim-diffchanges'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'henrik/vim-indexed-search'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-repeat'

" filetype stuff
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tpope/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'HerringtonDarkholme/yats.vim'   " typescript
Plugin 'tomlion/vim-solidity'
call vundle#end()            " required

" for vim-markdown-preview
let g:vim_markdown_preview_github=1
let g:vim_markdown_preview_browser = 'Google Chrome'

filetype plugin indent on    " required
" }}}

" Utility functions {{{
function! IsGitDir()
  let gitdir=system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let isnotgitdir=matchstr(gitdir, '^fatal:.*')
  return empty(isnotgitdir)
endfunction
" }}}

" Linting {{{
let g:ale_linters = {
\   'javascript': ['standard'],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_javascript_standard_use_global=0

nnoremap <leader>ll :ALELint<cr>
" }}}

" Key Mapping Setup {{{
" punishment {{{
inoremap <esc> <nop>
nnoremap <space> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <right> <nop>
nnoremap <left> <nop>
" }}}
let mapleader = " "
" }}}

" Gui settings {{{
set number
set relativenumber
set wiw=115
set hlsearch
set incsearch
syntax on
colorscheme darkblue
set background=dark
" wildmenu
set wildchar=<Tab> wildmenu wildmode=full
nnoremap <leader>N :setlocal number! relativenumber!<cr>
augroup titleBarGroup
  autocmd!
  autocmd BufEnter * let &titlestring = getcwd() . "       -----      " . expand("%")
augroup END

" Statusline {{{
set statusline=%f         " Path to the file
set statusline+=\ -\      " Separator
set statusline+=%y        " Filetype
set statusline+=%m
set statusline+=%=        " Switch to the right side
set statusline+=%c\ \     " Current column
set statusline+=\[%5l     " Current line
set statusline+=/         " Separator
set statusline+=%L\ \]    " Total lines
set laststatus=2
" }}}
" }}}

" Navigation {{{
vnoremap H 0
vnoremap L $
vnoremap J <PageDown>
vnoremap K <PageUp>

nnoremap H 0
nnoremap L $
nnoremap J <PageDown>
nnoremap K <PageUp>
nnoremap <leader>co :copen<cr>
nnoremap <leader>cj :cnext<cr>
nnoremap <leader>ck :cprevious<cr>

onoremap H 0
onoremap L $
onoremap J <PageDown>
onoremap K <PageUp>

cnoremap jk <C-c> 
inoremap jk <esc>

" copy the current file path and line number into the 'l' register
nnoremap <leader>yy :let@l=join([expand('%'),  line(".")], ':')<cr>
" }}}

" Windows and Tabs {{{
set splitbelow
set splitright

" easier than finding ctrl
nnoremap <leader>w <c-w>
nnoremap <leader>ww <c-w>c<c-w>

" tabs 
nnoremap <leader>tj :tabprevious<cr>
nnoremap <leader>tk :tabnext<cr>
nnoremap <leader>tJ :tabfirst<cr>
nnoremap <leader>tK :tablast<cr>
nnoremap <leader>tc :tabnew<cr>


function! OpenBufferInNewTab()
  let a:originalTab = tabpagenr()    |" find the current tab number
  echo a:originalTab
  if tabpagewinnr(a:originalTab, '$') ==# 1
    return 
  endif
  let a:buf = bufnr("%")             |" find buffer number
  tabnew                             |" open new tab
  let a:newTab = tabpagenr()
  :execute "b".a:buf          |" open buffer in new tab
  :execute a:originalTab."tabnext"   |" return to original tab
  :q                                 |" close window
  :execute a:newTab."tabnext"        |" return to new tab
endfunction
nnoremap <leader>tn :call OpenBufferInNewTab()<cr>
" }}}

" Filetype settings {{{
" Typescript file settings {{{
augroup typescriptFileTypeGroup
  autocmd!
  autocmd FileType typescript setlocal foldmethod=syntax
  autocmd FileType typescript setlocal foldlevel=3
  " ensure the typescript filetype is recognized
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
augroup END
" }}}

" Python file settings {{{
augroup pythonFileTypeGroup
  autocmd!
  autocmd FileType python nnoremap <buffer> <leader>/ I#<space><esc>
augroup END
" }}}

" Yaml file settings {{{
augroup yamlFileTypeGroup
  autocmd!
  autocmd FileType yaml setlocal foldmethod=indent
  autocmd FileType yaml setlocal foldnestmax=10 
  autocmd FileType yaml setlocal nofoldenable
  autocmd FileType yaml setlocal foldlevel=2
augroup END
" }}}

" Vimscript file settings {{{
augroup vimFileTypeGroup
  autocmd!
  " run source for vim files on save
  autocmd bufwritepost .vimrc execute "source %"
  autocmd FileType vim nnoremap <buffer> <leader>/ I"<space><esc>
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}

" Markdown file settings {{{
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

augroup markdownFileTypeGroup
  autocmd!
  autocmd FileType markdown setlocal foldexpr=MarkdownLevel()  
  autocmd FileType markdown setlocal foldmethod=expr  
  autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^\\(==\\+\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
  " alway preview markdown files on save
  " autocmd bufwritepost *.md :execute "call Vim_Markdown_Preview()"
augroup END
" }}}

" JSON file settings {{{
augroup jsonFileTypeGroup
  autocmd!
  autocmd FileType json setlocal foldmethod=indent
  autocmd FileType json setlocal foldnestmax=10 
  autocmd FileType json setlocal nofoldenable
  autocmd FileType json setlocal foldlevel=2
  " format json
  autocmd FileType json nnoremap <leader>jq :%!jq '.'<cr>
augroup END
" }}}

" LaTeX file settings {{{

augroup jsonFileTypeGroup
  autocmd!
  " on save, compile and preview
  autocmd bufwritepost *.tex :execute "silent !pdflatex -halt-on-error % && open -a Preview $(echo % | sed 's/tex$/pdf/')" 
augroup END
" }}}
" }}}

" Indentation {{{
 set expandtab
 set shiftwidth=2
 set autoindent
 set smartindent
" }}}

" Easy Align {{{
" Start interactive EasyAlign in visual mode 
xnoremap <leader>a :EasyAlign<cr>

" Start interactive EasyAlign for a motion/text object
nnoremap <leader>a :EasyAlign<cr>
" }}}

" Tab completion {{{
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
" }}}

" Run file {{{
" saves the current buffer into a temp file and runs it with source
function! RunFileInCurrentBuffer()
  if &filetype ==# "vim"
    write /tmp/vimrun
    source /tmp/vimrun
    !rm /tmp/vimrun
  elseif &filetype ==# "sh"
   execute "!source %"
  endif

endfunction
noremap <leader>r :call RunFileInCurrentBuffer()<cr><cr>
" }}}

" Highlighting {{{
" show errors
highlight Errors ctermbg=green guibg=darkred
nnoremap <leader>he :match Errors /\v\s+$/<cr>
nnoremap <leader>hE :match none<cr>

" set current line highlight in active window
highlight cursorline ctermbg=green guibg=darkgreen
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
 " }}}

" Search {{{
nnoremap / /\v
nnoremap <leader>sg :Ggrep<space>
nnoremap <leader>ss :Ggrep '<cword>' <cr>
" }}}

" File Navigation {{{
" open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" open bash_profile
nnoremap <leader>eb :vsplit ~/.bash_profile<cr>
" open .zshrc
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
" open my personal vim todo list 
nnoremap <leader>ea :vsplit ~/vim.annoyance<cr>
" fzf file searches
nnoremap <leader>en :vsplit notes.ariignore<cr>
nnoremap <leader>eg :GFiles<cr>
nnoremap <leader>et :NERDTree<cr>
" }}}

" Git {{{
" vim-fugitive commands
" use "g?" in these to bring up help
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gvdiff<cr>
nnoremap <leader>gps :Gpush<cr>
nnoremap <leader>gpl :Gpull<cr>
" }}}

" Copy Paste {{{
" yank to system clipboard
xnoremap <leader>c "+y 
nnoremap <leader>c "+y
" paste from system clipboard
nnoremap <leader>v "+p
" }}}
