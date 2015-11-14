" Plugged: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if $TERM != 'linux' || has("gui_running")
  Plug 'bling/vim-airline'
endif

" Colorschemes
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'

" Text formatting
Plug 'beloglazov/vim-textobj-quotes'
Plug 'cohama/lexima.vim'
Plug 'godlygeek/tabular'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-surround' "csXX, dsX, ysMX, yssX
Plug 'tpope/vim-repeat' "tpope plugin repeat

" Navigation
Plug 'critiqjo/gtags.vim'
Plug 'critiqjo/vsearch.vim'
Plug 'kana/vim-smartword'
Plug 'unblevable/quick-scope'

" Filetype-specific
Plug 'rust-lang/rust.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'zaiste/tmux.vim'

" Misc
Plug 'critiqjo/unite-fasd.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'powerman/vim-plugin-viewdoc'
Plug 'rking/ag.vim' , { 'on': ['Ag', 'AgBuffer', 'AgFile'] } "AgAdd AgFromSearch
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-fugitive'
