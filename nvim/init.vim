set nocompatible

" Install Plug if not already loaded
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif


call plug#begin()
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'terryma/vim-multiple-cursors'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

call plug#end()

function! PendingPlugInstall()
  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall

    if has('nvim')
      UpdateRemotePlugins
    endif
  endif
endfunction

autocmd VimEnter * call PendingPlugInstall()

" set theme
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
 
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set hidden
set number
set mouse=a
set inccommand=split
set termguicolors

let mapleader="\<space>"
nnoremap <leader>; A;<esc>

"emulate ctrl +p
nnoremap <c-p> :Files<cr>

nnoremap <c-f> :Ag<space>


