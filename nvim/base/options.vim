" -- UI
set background=dark
set diffopt+=vertical
set display+=lastline " Show as much of last line as possible
set foldmethod=marker
set hidden " Buffers can be hidden keeping its changes
set laststatus=2
set list
set listchars=tab:»\ ,trail:·
set number
set relativenumber " Relative line numbering
set ruler " Show line and column numbers
set scrolloff=1
set showcmd
set noshowmode
set splitright
set wildmenu " Enhanced command line suggestions
set wildmode=longest,full

" -- Usability
set autoindent
set backspace=indent,eol,start
set incsearch " Show results simultaneously while typing a search command
set ignorecase " of search patterns
set smartcase " smartly override ignorecase
set timeoutlen=1200 " <leader> timeout

" -- History management
set directory=~/.nvim/swps
set history=512
set undofile
set undodir=~/.nvim/undos
set undolevels=256  " Maximum number of changes that can be undone
set undoreload=2048 " Maximum number lines to save for undo on a buffer reload

" -- Formatting
set expandtab
set shiftwidth=4
set tabstop=4

" -- Session-saves
set ssop-=options " Do not store global and local options

" -- Spellcheck
set spellfile=~/.nvim/spell/en.utf-8.add
set spelllang=en
