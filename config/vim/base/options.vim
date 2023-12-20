set encoding=utf-8

" -- UI
set background=dark
set cursorline
set diffopt+=vertical
set display+=lastline " Show as much of last line as possible, followed by @@@
set display+=uhex " Show non-printable characters by their hex value
set foldmethod=marker
set hidden " Buffers can be hidden keeping its changes
set laststatus=2
set list
set listchars=tab:»\ ,trail:·
set mouse=nvi
set number
set ruler " Show line and column numbers
set scrolloff=1
set showcmd
set noshowmode
set showtabline=2
set splitright
" disable italics; italics+tmux=insanity!
set t_ZR=
set t_ZH=

" -- Usability
set autoindent
set backspace=indent,eol,start
set complete-=i " don't scan included files
set incsearch " incremental search: show results while typing in /
set ignorecase " of search patterns
set isfname-==  " so that <C-x><C-f> works when an = is followed by a path
set modeline
set nrformats-=octal " Disable octal format with <C-a> and <C-x>
set path=.,./**
set smartcase " smartly override ignorecase
set timeoutlen=1200 " <leader> timeout
set switchbuf=useopen,usetab " use open windows and tabs when using :sb*
set ttimeout
set ttimeoutlen=100
set wildignore=*.pyc,*.zwc,*/.git/**
set wildignorecase
set wildmenu " Enhanced command line suggestions
set wildmode=longest,full

" -- History management
let &directory = g:critiqjo#cache_dir . 'swps'
set history=512
let &undodir = g:critiqjo#cache_dir . 'undos'
set undofile
set undolevels=256  " Maximum number of changes that can be undone
set undoreload=2048 " Maximum number lines to save for undo on a buffer reload

" -- Formatting
set expandtab
set shiftwidth=4
set tabstop=4

" -- Session-saves
set ssop-=options " Do not store global and local options

" -- Spellcheck
let &spellfile = g:critiqjo#cache_dir . 'spell/en.utf-8.add'
set spelllang=en

if exists('$TMUX')
  " cursor shape change in tmux
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
elseif !has('gui_running')
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif
