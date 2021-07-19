set nocompatible
set encoding=utf-8

let g:critiqjo#rtp0_dir = $HOME . '/.vim/'
let g:critiqjo#cache_dir = $HOME . '/.cache/vim/'

" disable italics!!! italics+tmux=insanity!
set t_ZR=
set t_ZH=

" --- Plug Scripts {{{
call plug#begin(g:critiqjo#cache_dir . 'plugged')

exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs.vim'

call plug#end()
" --- Plug Scripts }}}

" --- Global Options {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/options.vim'

set nrformats-=octal " For use with <C-a> and <C-x>
set ttimeout
set ttimeoutlen=100
" --- Global Options }}}

" --- Plugin Options {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs-opts.vim'
" --- Plugin Options }}}

" --- Keymaps {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/keymaps.vim'

if !has('gui_running')
  map! ∆ <M-h>
  map! ˚ <M-j>
  map! ˙ <M-k>
  map! ¬ <M-l>

  "autopairs mapping
  imap ø <M-u>
  imap ß <M-s>

  " cursor shape change in tmux
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
  else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
  endif
endif
" --- Keymaps }}}

exe 'source ' . g:critiqjo#rtp0_dir . 'base/misc.vim'

" vim:fdm=marker:ts=2:sw=2
