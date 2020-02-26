" Display configuration
set number		" Display line number
set title		" Display file name
set showmatch	"
syntax on		" Sytnax highlight
set smartindent		" Autoindent
set laststatus=2
set paste

" Tab configuration
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

" Search settings
set hlsearch
set incsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

" Color scheme
colorscheme desert

" Key configuration
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python3 %
nnoremap tt :tabn<CR>
nnoremap th :tabp<CR>
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

