" Vundle config:
set nocompatible                        " be iMproved, required
filetype off                            " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle, required
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'bitc/vim-hdevtools'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'eagletmt/neco-ghc'
Plugin 'wting/rust.vim'

call vundle#end()                       " required
filetype plugin indent on               " required

" Non-Vundle config:
" set nocompatible                       " Necessary for cool stuff
colorscheme default
set ai                                  " Auto indent
set autoread                            " Set to auto read when a file is changed from the outside
set backspace=eol,start,indent          " Configure backspace so it acts as it should act
set cmdheight=2                         " Height of the command bar
set encoding=utf8                       " Set utf8 as standard encoding and en_US as the standard language
set expandtab                           " Use spaces instead of tabs
set ffs=unix,dos,mac                    " Use Unix as the standard file type
set hid                                 " A buffer becomes hidden when it is abandoned
set history=700                         " Sets how many lines of history VIM has to remember
set hlsearch                            " Highlight search results
set ignorecase                          " Ignore case when searching
set incsearch                           " Makes search act like search in modern browsers
set laststatus=2                        " Always show the status line
set magic                               " For regular expressions turn magic on
set mat=2                               " How many tenths of a second to blink when matching brackets
set mouse=a                             " Enable mouse
set nobackup                            " Turn backup off, since most stuff is in SVN, git et.c anyway...
set noerrorbells                        " No annoying sound on errors
set noswapfile
set novisualbell
set nowb
set number                              " Show line numbers
set ruler                               " Always show current position
set shiftwidth=4                        " 1 tab == 4 spaces
set showcmd                             " Shows what you are typing as a command
set showmatch                           " Show matching brackets when text indicator is over them
set si                                  " Smart indent
set smartcase                           " When searching try to be smart about cases
set smarttab                            " Be smart when using tabs ;)
set so=7                                " Set 7 lines to the cursor - when moving vertically using j/k
set tabstop=4
set tm=500
set t_vb=
set virtualedit=all                     " Enable free-range cursor
set whichwrap+=<,>,h,l
set wildignore=*.o,*~,*.pyc             " Ignore compiled files
set wildmenu                            " Turn on the WiLd menu
syntax enable                           " Enable syntax highlighting
"set spell                               " Use spell check (it's really annoying)
set nowrap                              " Don't wrap lines
set clipboard=unnamedplus               " Use X11 clipboard for yanks

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
autocmd FileType xml setlocal shiftwidth=2
autocmd FileType xml setlocal tabstop=2

let g:ycm_global_ycm_extra_conf = '~/.ycm/ycm_global.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:syntastic_haskell_checkers = ['hdevtools']
let g:syntastic_haskell_hdevtools_args = '-g-Wall'

setlocal omnifunc=necoghc#omnifunc

let g:necoghc_enable_detailed_browse = 1

let g:EclimCompletionMethod = 'omnifunc'

" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif

let g:airline_powerline_fonts = 1

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.* :call DeleteTrailingWS()

