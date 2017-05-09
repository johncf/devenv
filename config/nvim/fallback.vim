set nocompatible

let g:critiqjo#rtp0_dir = $HOME . '/.vim/'
let g:critiqjo#cache_dir = $HOME . '/.cache/nvim/'

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
  imap <Esc>h <M-h>
  imap <Esc>j <M-j>
  imap <Esc>k <M-k>
  imap <Esc>l <M-l>
  imap <Esc>o <M-o>
  imap <Esc>O <M-O>
  "autopairs mapping
  imap <Esc>u <M-u>
  imap <Esc>s <M-s>

  inoremap <nowait> <Esc> <Esc>

  nmap <Esc>h <M-h>
  nmap <Esc>j <M-j>
  nmap <Esc>k <M-k>
  nmap <Esc>l <M-l>
  nnoremap <nowait> <Esc> <Esc>

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
