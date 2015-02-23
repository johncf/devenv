set nocompatible

" pathogen: infect '.nvim/bundle' directory
execute pathogen#infect()

set showcmd
set hidden "buffers can be hidden keeping its changes
set number
set relativenumber "relative line numbering
set ruler "show line and column numbers
set textwidth=78
set backspace=indent,eol,start
set timeoutlen=2000 ttimeoutlen=100 "<leader> will have 2000ms timeout but 
									"<Esc> will have only 100ms timeout

set directory=~/.nvim/swps
set undofile
set undodir=~/.nvim/undos
set undolevels=512	"maximum number of changes that can be undone
set undoreload=8192	"maximum number lines to save for undo on a buffer reload

set tabstop=4
set shiftwidth=4
set incsearch " While typing a search command, show immediately where the
              " so far typed pattern matches.et scrolloff=2
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
 
syntax on
"set hlsearch " highlighting of last used search pattern
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on
filetype plugin indent on

" Don't go to Ex mode
map Q gq

" Use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
inoremap qj <Esc>
inoremap <C-H> <S-Left>
inoremap <C-L> <S-Right>

" C-mode: <C-B> Home; <C-E> End; <C-F> C-window; <C-U> clear-back;
" <C-C> C-exit; <C-D> list-opts; <C-W> del-word
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-H> <S-Left>
cnoremap <C-L> <S-Right>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a " See :help mouse
"endif

noremap <S-Tab> :tab sp
noremap <leader>q :bp <BAR> bd #<CR>
noremap <leader>n :NERDTreeToggle<CR>
"let g:NERDTreeWinSize = 30 " Set NERDTree window width

colorscheme desertEx-v2

"cscope stuff --begin--
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
	endif
endfunction
au BufEnter /*.{c,h} call LoadCscope()
"cscope stuff --end--

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				 \ | wincmd p | diffthis
endif
