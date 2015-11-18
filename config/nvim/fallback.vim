set nocompatible

let g:critiqjo#rtp0_dir = $HOME . '/.vim/'
let g:critiqjo#cache_dir = $HOME . '/.cache/nvim/'

" --- Plug Scripts {{{
call plug#begin(g:critiqjo#cache_dir . 'plugged')

exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs.vim'

Plug 'Shougo/vimproc.vim' , { 'do': 'make' }
Plug 'Shougo/neocomplete.vim'

call plug#end()
" --- Plug Scripts }}}

" --- Global Options {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/options.vim'

set omnifunc=syntaxcomplete#Complete
set nrformats-=octal " For use with <C-a> and <C-x>
set ttimeout
set ttimeoutlen=100
" --- Global Options }}}

" --- Plugin Options {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugin-opts.vim'

" --- Neocomplete options {{{
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Plugin key-mappings.
inoremap <expr> <C-n> neocomplete#start_manual_complete()
"inoremap <expr> <C-l> neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr> <CR> neocomplete#close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr> <C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr> <BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr> <C-y> neocomplete#close_popup()
inoremap <expr> <C-e> neocomplete#cancel_popup()
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" --- Neocomplete options }}}
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

  inoremap <nowait> <Esc> <Esc>
endif
" --- Keymaps }}}

exe 'source ' . g:critiqjo#rtp0_dir . 'base/misc.vim'

" vim:fdm=marker:ts=2:sw=2
