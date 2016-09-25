" ============================= Backup Options ============================= "
set nobackup
set nowritebackup
set noswapfile

" =========================== Indentation Options ========================== "
colorscheme default

set background=dark
set colorcolumn=81
set expandtab
set nowrap
set shiftwidth=2
set smartindent
set tabstop=2

" ============================ Interface Options =========================== "
set number
set ruler
set scrolloff=7
set showmatch
set virtualedit=all
set wildmenu
set clipboard+=unnamedplus

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

" ========================== Plugin Initialization ========================= "
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline'
call plug#end()

call deoplete#enable()

let g:airline_powerline_fonts = 1

" =========================== File Type Specific =========================== "
autocmd FileType gitcommit set colorcolumn=73
