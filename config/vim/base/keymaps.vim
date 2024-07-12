" --- Cursor Movements {{{

" Colemak keymaps
set langmap=kj,jh,hk

noremap <silent> <Up> g<Up>
noremap <silent> <Down> g<Down>

" Alternate between first character and first non-space character
nnoremap <expr> 0 getpos('.')[2]==1 ? "_" : "0"

nnoremap <C-k> j<C-e>
nnoremap <C-h> k<C-y>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

inoremap <M-h> <Up>
inoremap <M-j> <Left>
inoremap <M-k> <Down>
inoremap <M-l> <Right>

" --- }}}

set pastetoggle=<F2>

if stridx(&rtp, 'smartword') > 0
  map w <Plug>(smartword-w)
  map b <Plug>(smartword-b)
  map e <Plug>(smartword-e)
  map ge <Plug>(smartword-ge)
endif

" Avoid going to Ex mode
nnoremap Q <Nop>
" alternatively, `nnoremap Q q:` to open cmdline-window

nnoremap Y y$

" Make <C-u> and <CR> undoable
inoremap <C-u> <C-g>u<C-u>
inoremap <CR> <C-g>u<CR>

let mapleader = "\<Space>"
noremap <leader> <Nop>
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p "+p
nnoremap <leader>P "+P

nnoremap <leader>cd :cd %:h<CR>
nnoremap <silent> <leader>cl :set invcursorline<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>f :find<Space><C-d>
nnoremap <leader>hh :set nonu nornu nolist conceallevel=2<CR>
nnoremap <silent> <leader>hl :HighlightToggle<CR>
nnoremap <leader>b :ls<CR>:b
nnoremap <leader>m :MouseToggle<CR>
nnoremap <leader>n :<C-u>b <C-r>=critiqjo#get_file_buf(v:count, 1)<CR><CR>
nnoremap <leader>N :<C-u>b <C-r>=critiqjo#get_file_buf(v:count, -1)<CR><CR>
nnoremap <leader>o :Unite fasd:mru -start-insert<CR>
nnoremap <leader>O :Unite fasd:mru:reload -start-insert<CR>
nnoremap <leader>q :call critiqjo#buf_close()<CR>
nnoremap <leader>Q :qall<CR>
nnoremap <leader>s :set invspell<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>vo :call critiqjo#only_visible()<CR>
nnoremap <leader>w :update<CR>

if !has('gui_running')
  " Fix Meta-key mappings in insert mode
  imap <Esc>h <M-h>
  imap <Esc>j <M-j>
  imap <Esc>k <M-k>
  imap <Esc>l <M-l>

  " Handle arrow keys correctly in insert mode
  inoremap <Esc>OA <Up>
  inoremap <Esc>OB <Down>
  inoremap <Esc>OD <Left>
  inoremap <Esc>OC <Right>

  inoremap <nowait> <Esc> <Esc>
endif
