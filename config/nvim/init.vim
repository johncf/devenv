let g:critiqjo#rtp0_dir = $HOME . '/.config/nvim/'
let g:critiqjo#cache_dir = $HOME . '/.cache/nvim/'

" --- Plug Scripts {{{
call plug#begin(g:critiqjo#cache_dir . 'plugged')

exe 'source ' . g:critiqjo#rtp0_dir . 'base/plugs.vim'

Plug 'christoomey/vim-tmux-navigator'

"Plug 'critiqjo/lldb.nvim'

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

nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Make ZQ redoable!
nnoremap ZQ :call critiqjo#redoable_zq()<CR>

nmap <M-b> <Plug>LLBreakSwitch
" --- Keymaps }}}

exe 'source ' . g:critiqjo#rtp0_dir . 'base/misc.vim'

" vim:fdm=marker:ts=2:sw=2
