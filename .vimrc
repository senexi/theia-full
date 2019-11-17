set encoding=utf-8
set fileencoding=utf-8
set omnifunc=go#complete#Complete

syntax on
set tabstop=4

" Enable filetype plugins 
filetype plugin on

" Explorer
nnoremap ee :Ex<CR>
let g:netrw_liststyle = 3
let g:netrw_list_hide='.*\.swp$'
augroup ProjectDrawer
  autocmd!
  "autocmd VimEnter * :Vexplore
augroup END

syntax on
"set mouse=a
set splitbelow
" remap split switchting
let mapleader = ","
nnoremap <Leader>w <C-w>
nnoremap <C-a> <C-w>
nnoremap <Leader>j :tabprevious<CR>                                  
nnoremap <Leader>k :tabnext<CR>

" enable fzf
set rtp+=~/.fzf
nnoremap ff :GFiles<CR>
" lightline
set laststatus=2
set noshowmode

" map last command
:noremap ll @:<CR>

" map new tab
nnoremap tt :tabnew<CR>

" map quit all
 nnoremap qq :qa!<CR>

" color theme
colo molokai

