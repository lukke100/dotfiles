" ============================== Backup Options ============================== "
set nobackup
set nowritebackup
set noswapfile
set noundofile

" =========================== Indentation Options ============================ "
colorscheme default

set background=light
set backspace=indent,eol,start
set colorcolumn=80
set expandtab
set nojoinspaces
set nowrap
set shiftwidth=4
set smartindent
set tabstop=4
set textwidth=79

" ============================ Interface Options ============================= "
syntax on

set number
set ruler
set scrolloff=7
set showmatch
set virtualedit=all
set wildmenu

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

" ============================ File Type Specific ============================ "
autocmd FileType gitcommit setlocal colorcolumn=73
autocmd FileType gitcommit setlocal textwidth=72
