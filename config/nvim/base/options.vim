" -- UI
set background=dark
"set breakindent
set diffopt+=vertical
set display+=lastline " Show as much of last line as possible
set foldmethod=marker
set hidden " Buffers can be hidden keeping its changes
set laststatus=2
"set linebreak " word-wrap
set list
set listchars=tab:»\ ,trail:·
set number
set relativenumber " Relative line numbering
set ruler " Show line and column numbers
set scrolloff=1
set showcmd
set noshowmode
set showtabline=2
set splitright

" -- Usability
set autoindent
set backspace=indent,eol,start
set complete-=i " don't scan included files
set incsearch " Show results simultaneously while typing a search command
set ignorecase " of search patterns
set isfname-==  " so that <C-x><C-f> works when an = is followed by a path
set path=.,./**
set smartcase " smartly override ignorecase
set timeoutlen=1200 " <leader> timeout
set switchbuf=useopen,usetab " use open windows and tabs when using :sb*
set wildignore=*.pyc,*.zwc,*/.git/**
set wildignorecase
set wildmenu " Enhanced command line suggestions
set wildmode=longest,full

" -- History management
exe 'set directory=' . g:critiqjo#cache_dir . 'swps'
set history=512
exe 'set undodir=' . g:critiqjo#cache_dir . 'undos'
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
exe 'set spellfile=' . g:critiqjo#cache_dir . 'spell/en.utf-8.add'
set spelllang=en
