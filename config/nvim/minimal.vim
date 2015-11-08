set nocompatible

let cache_dir = $HOME . '/.cache/nvim/'

" --- Plug Scripts {{{
" Plugged: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin(cache_dir . 'plugged')
Plug 'morhetz/gruvbox'
Plug 'kana/vim-smartword'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'powerman/vim-plugin-viewdoc'
Plug 'critiqjo/vim-autoclose'
call plug#end()
" --- }}}

" --- Pathogen (disabled) {{{
" Pathogen: https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Zip URLs: https://github.com/{user}/{repo}/archive/master.zip
"execute pathogen#infect()
" --- }}}

" --- Global Options {{{
set bg=dark dip+=vertical
set dy+=lastline fdm=marker
set hid hls nu ru sc so=1 spr
set et sw=4 ts=4 ai is ic scs
set bs=indent,eol,start
set path=.,./**
set tm=1200 ttimeout ttm=100
set wmnu wic wim=longest,full

exe 'set dir=' . cache_dir . 'swps'
exe 'set udir=' . cache_dir . 'undos'
set hi=512 udf ul=256 ur=2048
" --- }}}

let g:viewdoc_openempty = 0

" --- Keymaps {{{
if stridx(&rtp, 'smartword') > 0
  map w <Plug>(smartword-w)
  map b <Plug>(smartword-b)
  map e <Plug>(smartword-e)
  map ge <Plug>(smartword-ge)
endif

inoremap zj <Esc>
vnoremap zj <Esc>

nnoremap Q q:
nnoremap Y y$

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-u> <C-g>u<C-u>
inoremap <CR> <C-g>u<CR>
noremap! <M-h> <Left>
noremap! <M-j> <Down>
noremap! <M-k> <Up>
noremap! <M-l> <Right>
noremap! <M-x> <Del>
cnoremap <C-a> <Home>
cnoremap <M-b> <S-Left>
cnoremap <M-e> <S-Right>

let mapleader = "\<Space>"
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>hl :nohl<CR>
nnoremap <leader>n :exe v:count . 'bn'<CR>
nnoremap <leader>N :exe v:count . 'bN'<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>Q :qall<CR>
nnoremap <leader>w :update<CR>
" --- }}}

" --- Misc {{{
filetype plugin indent on
colorscheme gruvbox
syntax enable

augroup critiq_au
  autocmd!
  autocmd FileType qf nnoremap <buffer> <nowait> q <C-w>q | setlocal nonu nornu
  autocmd FileType man\|help\|pydoc\|info
      \ if &bt == "nofile" |
      \   nnoremap <buffer> <nowait> d <C-d> |
      \   nnoremap <buffer> <nowait> u <C-u> |
      \ endif
augroup END
" --- }}}

" vim:fdm=marker:ts=2:sw=2
