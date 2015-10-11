" # vim-plug installation: {{{
" mkdir -p ~/.nvim/autoload
" curl -fLo ~/.nvim/autoload/plug.vim \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" # }}}

Plug 'mhinz/vim-startify'
Plug 'bling/vim-airline'

Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'
Plug 'antlypls/vim-colors-codeschool'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-smartword'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround' "csXX, dsX, ysMX, yssX
"Plug 'tpope/vim-abolish' "Abbreviation, substitution, coercion
Plug 'tpope/vim-repeat' "tpope plugin repeat
Plug 'unblevable/quick-scope'

Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim' , { 'on': ['Ag', 'AgBuffer', 'AgFile'] } "AgAdd AgFromSearch

Plug 'powerman/vim-plugin-viewdoc'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

Plug 'rust-lang/rust.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'zaiste/tmux.vim'

Plug 'critiqjo/gtags.vim'
Plug 'critiqjo/unite-fasd.vim'
Plug 'critiqjo/vim-autoclose'
Plug 'critiqjo/vsearch.vim'
