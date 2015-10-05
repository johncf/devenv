map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

" URL/XML/CString En/Decode maps: [X ]X where X=[uxy]
call u_transform#map('string_encode', '[y')
call u_transform#map('string_decode', ']y')
call u_transform#map('url_encode', '[u')
call u_transform#map('url_decode', ']u')
call u_transform#map('xml_encode', '[x')
call u_transform#map('xml_decode', ']x')

" Switch to normal mode
inoremap zj <Esc>
vnoremap zj <Esc>

" Don't go to Ex mode, open cmd-line window instead.
nnoremap Q q:
nnoremap Y y$
nnoremap <expr> 0 (getcurpos()[2]==1 ? "_" : "0")
nnoremap <expr> $ (getcurpos()[4]>1.0E9 ? "g_" : "$")

nnoremap <C-j> j<C-e>
nnoremap <C-k> k<C-y>
nnoremap <silent> gH :call cursor(getcurpos()[1] - winline()/2, 0)<CR>
nnoremap <silent> gL :call cursor(getcurpos()[1] + (winheight('%')-winline())/2, 0)<CR>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
" Make <C-u> and <CR> undoable
inoremap <C-u> <C-g>u<C-u>
inoremap <CR> <C-g>u<CR>

" C-mode: <C-b> Home; <C-e> End; <C-f> C-window; <C-h> backspace
"         <C-c> C-exit; <C-d> list-opts; <C-u> clear-back; <C-w> del-word
cnoremap <C-a> <Home>
" idea from tpope/vim-rsi -- mimic line kill if not at the end of line
cnoremap <expr> <C-k> getcmdpos()>strlen(getcmdline()) ? "<C-k>" :
        \ getcmdpos()<2 ? "<C-e><C-u>" : "<C-\>egetcmdline()[0:getcmdpos()-2]<CR>"

noremap! <M-h> <Left>
noremap! <M-j> <Down>
noremap! <M-k> <Up>
noremap! <M-l> <Right>
noremap! <M-x> <Del>
cnoremap <M-b> <S-Left>
cnoremap <M-e> <S-Right>

let mapleader = "\<Space>"
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p o<Esc>"+p
nnoremap <leader>P O<Esc>"+p

nnoremap <leader>/ :Unite line:buffers -start-insert<CR>
nnoremap <leader>ib :Unite -quick-match -vertical -winwidth=60 buffer<CR>
nnoremap <leader>id :call critiqjo#unite_dir()<CR>
nnoremap <leader>iy :Unite history/yank<CR>

nnoremap <leader>cd :cd %:h<CR>
nnoremap <silent> <leader>cl :set invcursorline<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>do :DiffOrig<CR>
nnoremap <leader>hh :set nonu nornu nolist conceallevel=2<CR>
nnoremap <silent> <leader>hl :nohl<CR>
nnoremap <leader>m :MouseToggle<CR>
nnoremap <leader>n :<C-u>b <C-r>=critiqjo#get_ma_buf(v:count, 1)<CR><CR>
nnoremap <leader>N :<C-u>b <C-r>=critiqjo#get_ma_buf(v:count, -1)<CR><CR>
nnoremap <leader>o :Unite fasd:mru -start-insert<CR>
nnoremap <leader>O :Unite fasd:mru:reload -start-insert<CR>
nnoremap <leader>q :call critiqjo#buf_close()<CR>
nnoremap <leader>Q :qall<CR>
nnoremap <leader>s :set invspell<CR>
nnoremap <leader>tq :tabc<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>vo :call critiqjo#only_visible()<CR>
nnoremap <leader>w :update<CR>
