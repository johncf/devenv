" Colemak keymaps
set langmap=kj,jh,hk
set pastetoggle=<F2>

nnoremap <silent> <M-h> <C-w><Left>
nnoremap <silent> <M-j> <C-w><Down>
nnoremap <silent> <M-k> <C-w><Up>
nnoremap <silent> <M-l> <C-w><Right>

if stridx(&rtp, 'smartword') > 0
  map w <Plug>(smartword-w)
  map b <Plug>(smartword-b)
  map e <Plug>(smartword-e)
  map ge <Plug>(smartword-ge)
endif

" Don't go to Ex mode, open cmd-line window instead.
nnoremap Q q:
nnoremap Y y$
nnoremap <expr> 0 getpos('.')[2]==1 ? "_" : "0"

nnoremap <C-j> j<C-e>
nnoremap <C-k> k<C-y>
nnoremap <silent> gH :call cursor(getpos('.')[1] - winline()/2, 0)<CR>
nnoremap <silent> gL :call cursor(getpos('.')[1] + (winheight('%')-winline())/2, 0)<CR>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
" Make <C-u> and <CR> undoable
inoremap <C-u> <C-g>u<C-u>
inoremap <CR> <C-g>u<CR>

inoremap <M-b> <C-o>b
inoremap <M-d> <C-o>d
inoremap <M-e> <C-o>e<Right>
inoremap <M-w> <C-o>w
inoremap <M-o> <Esc>o
inoremap <M-O> <Esc>O
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

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
nnoremap <silent> <leader>hl :nohl<CR>
nnoremap <leader>m :MouseToggle<CR>
nnoremap <leader>n :<C-u>b <C-r>=critiqjo#get_file_buf(v:count, 1)<CR><CR>
nnoremap <leader>N :<C-u>b <C-r>=critiqjo#get_file_buf(v:count, -1)<CR><CR>
nnoremap <leader>o :Unite fasd:mru -start-insert<CR>
nnoremap <leader>O :Unite fasd:mru:reload -start-insert<CR>
nnoremap <leader>q :call critiqjo#buf_close()<CR>
nnoremap <leader>Q :qall<CR>
nnoremap <leader>r :<C-u><C-r>='let @'.v:register.' = '.string(getreg(v:register))<CR><C-f><Left>
nnoremap <leader>s :set invspell<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>vo :call critiqjo#only_visible()<CR>
nnoremap <leader>w :update<CR>
