" ============================== Backup Options ============================== "
set nobackup
set nowritebackup
set noswapfile

" =========================== Indentation Options ============================ "
colorscheme default

set background=dark
set colorcolumn=80
set expandtab
set nojoinspaces
set nowrap
set shiftwidth=2
set smartindent
set tabstop=2
set textwidth=79

" ============================ Interface Options ============================= "
set number
set ruler
set scrolloff=7
set showmatch
set virtualedit=all
set wildmenu
set clipboard+=unnamedplus

" ============================ Searching Options ============================= "
set ignorecase
set magic
set smartcase

" ======================== Remove Trailing Whitespace ======================== "
autocmd BufWrite *.* : call DeleteTrailingWS()

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" ========================== Plugin Initialization =========================== "
call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'neomake/neomake'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'zchee/deoplete-jedi'
call plug#end()

call deoplete#enable()

let g:airline_powerline_fonts = 1

" ============================ File Type Specific ============================ "
let g:syntastic_python_checkers = ['flake8', 'pylint']

autocmd CompleteDone * pclose!

autocmd FileType gitcommit set colorcolumn=73
autocmd FileType gitcommit set textwidth=72

autocmd FileType make set tabstop=8
