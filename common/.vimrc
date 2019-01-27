" Display configuration
set number		" Display line number
set title		" Display file name
set showmatch	"
syntax on		" Sytnax highlight
set smartindent		" Autoindent

" Tab configuration
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

" Color scheme
colorscheme desert

" Key configuration
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python3 %

