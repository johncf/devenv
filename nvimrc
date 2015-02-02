set nocompatible

" pathogen: infect '.nvim/bundle' directory
execute pathogen#infect()

noremap <leader>n :NERDTree<CR>
" Set NERDTree window width:
"let g:NERDTreeWinSize = 30

set ruler
set showcmd
set hidden "buffers can be hidden keeping its changes
set number
set relativenumber
set backspace=indent,eol,start
set timeoutlen=2000 ttimeoutlen=100 "<leader> will have 2000ms timeout but 
                                    "<Esc> will have only 100ms timeout

set directory=~/.nvim/swps
set undofile          "enable persistent undos
set undodir=~/.nvim/undos
set undolevels=512    "maximum number of changes that can be undone
set undoreload=8192   "maximum number lines to save for undo on a buffer reload

set tabstop=4
set shiftwidth=4
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.et scrolloff=2
 
syntax on
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on
filetype plugin indent on

" Use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap qq <Esc>
inoremap ZZ <Esc>

noremap <S-Tab> :tab sp

colorscheme 256-grayvim
colorscheme desertEx

"cscope stuff --begin--
function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /*.{c,h} call LoadCscope()
"cscope stuff --end--

