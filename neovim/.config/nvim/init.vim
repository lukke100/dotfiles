" ============================== Backup Options ============================== "
set nobackup
set nowritebackup
set noswapfile

" =========================== Indentation Options ============================ "
colorscheme default

set background=light
set colorcolumn=80
set expandtab
set list
set listchars=tab:»⋅,trail:⋅
set nojoinspaces
set nowrap
set shiftwidth=4
set smartindent
set tabstop=4
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

" NOTE: The root user shouldn't install plugins.
if ! (systemlist('id -u')[0] ==# 0)
    call plug#begin()
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neoinclude.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/vim-easy-align'
    Plug 'neomake/neomake'
    Plug 'scrooloose/syntastic'
    Plug 'vim-airline/vim-airline'
    Plug 'zchee/deoplete-clang'
    Plug 'zchee/deoplete-jedi'
    Plug 'zchee/libclang-python3'
    call plug#end()

    call deoplete#enable()

    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header  = '/usr/lib/clang/'

    let g:airline_powerline_fonts = 1
endif

" ============================ File Type Specific ============================ "
let g:syntastic_python_checkers = ['flake8', 'pylint']

autocmd CompleteDone * pclose!

autocmd FileType gitcommit setlocal colorcolumn=73
autocmd FileType gitcommit setlocal textwidth=72

autocmd FileType c,cpp,make setlocal noexpandtab shiftwidth=8  tabstop=8
