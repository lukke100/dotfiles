" ========================================================================== "
" ============================== Vundle Init =============================== "
" ========================================================================== "
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ============================== Plugin List =============================== "
Plugin 'gmarik/Vundle.vim'

call vundle#end()


" ========================================================================== "
" ============================= Backup Options ============================= "
" ========================================================================== "
set nobackup
set nowritebackup
set noswapfile


" ========================================================================== "
" ============================ Encoding Options ============================ "
" ========================================================================== "
set encoding=utf8
set ffs=unix,dos,mac


" ========================================================================== "
" ======================= File Type Specific Options ======================= "
" ========================================================================== "
autocmd FileType xhtml setlocal shiftwidth=2
autocmd FileType xhtml setlocal tabstop=2
autocmd FileType xml setlocal shiftwidth=2
autocmd FileType xml setlocal tabstop=2


" ========================================================================== "
" =========================== Indentation Options ========================== "
" ========================================================================== "
set autoindent
set expandtab
set nowrap
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4


" ========================================================================== "
" ============================ Interface Options =========================== "
" ========================================================================== "
colorscheme slate

filetype indent on
filetype plugin on

set background=dark
set backspace=eol,start,indent
set hidden
set lazyredraw
set matchtime=2
set noerrorbells
set novisualbell
set number
set ruler
set scrolloff=7
set showmatch
set t_vb=
set timeoutlen=500
set virtualedit=all
set wildmenu

syntax enable


" ========================================================================== "
" ============================ Searching Options =========================== "
" ========================================================================== "
set hlsearch
set ignorecase
set incsearch
set magic
set smartcase


" ========================================================================== "
" ======================= Remove Trailing Whitespace ======================= "
" ========================================================================== "
autocmd BufWrite *.* : call DeleteTrailingWS()

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
