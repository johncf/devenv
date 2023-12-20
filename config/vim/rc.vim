set nocompatible

let g:critiqjo#rtp0_dir = $HOME . '/.vim/'
let g:critiqjo#cache_dir = $HOME . '/.cache/vim/'

" --- Plug Scripts
call plug#begin(g:critiqjo#cache_dir . 'plugged')
exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs.vim'
call plug#end()

" --- Global Options
exe 'source ' . g:critiqjo#rtp0_dir . 'base/options.vim'

" --- Plugin Options
exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs-opts.vim'

" --- Keymaps
exe 'source ' . g:critiqjo#rtp0_dir . 'base/keymaps.vim'

" --- Custom Logic (color, au, com)
exe 'source ' . g:critiqjo#rtp0_dir . 'base/misc.vim'

" vim:fdm=marker:ts=2:sw=2
