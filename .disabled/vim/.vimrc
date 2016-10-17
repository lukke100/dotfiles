" ============================== Backup Options ============================== "
set nobackup
set nowritebackup
set noswapfile
set noundofile

" =========================== Indentation Options ============================ "
colorscheme slate

set background=dark
set backspace=indent,eol,start
set colorcolumn=81
set expandtab
set nojoinspaces
set nowrap
set shiftwidth=2
set smartindent
set tabstop=2
set textwidth=80

" ============================ Interface Options ============================= "
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
autocmd FileType gitcommit set colorcolumn=73
autocmd FileType gitcommit set textwidth=72
