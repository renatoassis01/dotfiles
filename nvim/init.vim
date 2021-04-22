set nocompatible

" Install Plug if not already loaded
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif


call plug#begin()
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'mateusbraga/vim-spell-pt-br'                                                 " pt-br spell checker
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'                                                      " dev icons
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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
  let &t_7f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_7b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set hidden
set number                                                      " set number lines
set mouse=a                                                     " set support mouse
set inccommand=split
set clipboard+=unnamedplus                                      " set clipboard
set termguicolors 						                                  " Enables 24-bit RGB color
set shortmess+=I 						                                    " Remove nvim intro message
set noswapfile                                                  " avoid swap files
set nobackup                                                    " avoid bkp files
set nowritebackup                                               " no make a backup before overwriting file
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload
set showbreak=↪                                                 " show arrow at wrap
set autoindent						                                     	" align the new line indent with the previous line
set updatetime=300                                              " update quickly
set omnifunc=syntaxcomplete#Complete                            " enable autocomplete
set showmode                                                    " don't show pressed commands
filetype plugin indent on                                       " recognizes filetype, plugins and indent
set signcolumn=yes                                              " keep sign column (gutter)
au FileType markdown setl spelllang=pt_br,en spell              " spellcheck on markdown

" Auto Commands
" remove trailing whitespace on save
autocmd! BufWritePre * :%s/\s\+$//e
" remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END


" fzf .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

set statusline=
set statusline+=\                                              " vim symbol
set statusline+=\ %{GitStatus()}
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %{FilenameStatusline()}



" keymaps
let mapleader="\<space>"
nnoremap <leader>; A;<esc>

"emulate ctrl +p
nnoremap <c-p> :Files<cr>

" ctrl + h
nnoremap <c-h> :Ag<space>

" list buffers
nnoremap <silent> <leader>b :Buffers<CR>


" config nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

let NERDTreeIgnore=[".git", "node_modules", "dist"]

" functions
function! FilenameStatusline()
    let l:filetype_symbol = WebDevIconsGetFileTypeSymbol()
    let l:filetype_name = expand('%:t')
    return printf(' %s %s ', filetype_symbol, filetype_name)
endfunction

function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
