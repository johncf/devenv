let g:critiqjo#rtp0_dir = $HOME . '/.config/nvim/'
let g:critiqjo#cache_dir = $HOME . '/.cache/nvim/'

" --- Plug Scripts {{{
call plug#begin(g:critiqjo#cache_dir . 'plugged')

exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs.vim'

Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'

Plug 'critiqjo/lldb.nvim'

call plug#end()
" --- Plug Scripts }}}

if get(g:, 'critiqjo#loaded', 0) == 1
  finish
endif
let g:critiqjo#loaded = 1

" --- Global Options {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/options.vim'

set lazyredraw " Faster <C-o> mappings in insert mode with airline
set mouse=
" --- Global Options }}}

" --- Plugin Options {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugin-opts.vim'

let g:tmux_navigator_no_mappings = 1
" --- Plugin Options }}}

" --- Keymaps {{{
exe 'source ' . g:critiqjo#rtp0_dir . 'base/keymaps.vim'

tnoremap zj <C-\><C-n>

" Make ZQ redoable!
nnoremap ZQ :call critiqjo#redoable_zq()<CR>

nmap <M-b> <Plug>LLBreakSwitch

nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" --- Meta-keymaps t-mode {{{
tnoremap <M-b> <Esc>b
tnoremap <M-d> <Esc>d
tnoremap <M-f> <Esc>f
tnoremap <M-F> <Esc>F
tnoremap <M-h> <Esc>h
tnoremap <M-j> <Esc>j
tnoremap <M-k> <Esc>k
tnoremap <M-l> <Esc>l
tnoremap <M-n> <Esc>n
tnoremap <M-p> <Esc>p
tnoremap <M-u> <Esc>u
tnoremap <M-w> <Esc>w
tnoremap <M-x> <Esc>x
" --- Meta-keymaps }}}
" --- Keymaps }}}

exe 'source ' . g:critiqjo#rtp0_dir . 'base/misc.vim'

" vim:fdm=marker:ts=2:sw=2
