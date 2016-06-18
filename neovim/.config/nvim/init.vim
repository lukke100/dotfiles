" ============================= Backup Options ============================= "
set nobackup
set nowritebackup
set noswapfile

" =========================== Indentation Options ========================== "
set expandtab
set nowrap
set shiftwidth=2
set smartindent
set tabstop=2

" ============================ Interface Options =========================== "
set background=dark
set number
set ruler
set scrolloff=7
set showmatch
set virtualedit=all
set wildmenu

" ============================ Searching Options =========================== "
set ignorecase
set magic
set smartcase

" ======================= Remove Trailing Whitespace ======================= "
autocmd BufWrite *.* : call DeleteTrailingWS()

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
