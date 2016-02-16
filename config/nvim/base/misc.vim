filetype plugin indent on
let s:colors_fav = [ 'desertEx-v2', 'alduin', 'sierra', 'apprentice', 'desert' ]

function! s:colors_cycle()
  let color_next = s:colors_fav[s:colors_idx]
  let s:colors_idx += 1
  let s:colors_idx = s:colors_idx % len(s:colors_fav)
  exe 'colorscheme ' . color_next
endfun

if has("gui_running")
  let g:sierra_Twilight = 1
  let s:colors_idx = 2
  set guifont=MonacoB
  set guioptions-=T "toolbar
  set guioptions-=r "scrollbar
  set guioptions-=m "menubar
elseif $TERM == 'linux'
  let s:colors_idx = -1
else
  let s:colors_idx = system('echo $RANDOM') % 2
endif
call s:colors_cycle()
syntax enable

" --- Autocommands {{{
augroup critiq_au
  autocmd!
  autocmd BufRead,BufNewFile *.ll set filetype=llvm
  autocmd FileType netrw nnoremap <buffer> <nowait> q <C-^> | nmap <buffer> <Space> mf
  autocmd FileType qf nnoremap <buffer> <nowait> q <C-w>q | setlocal nonu nornu
  autocmd FileType vim\|python setlocal ts=2 sw=2
  autocmd FileType man\|help\|pydoc\|info
      \ if &bt == "nofile" |
      \   nnoremap <buffer> <nowait> d <C-d> |
      \   nnoremap <buffer> <nowait> u <C-u> |
      \ endif
  autocmd WinLeave,InsertEnter * setlocal nocursorline
  autocmd WinEnter,BufEnter * if &g:cursorline | setlocal cursorline | endif
  "autocmd VimEnter * let g:unite_fasd#read_only = 0
augroup END
" --- Autocommands }}}

" --- Command defs {{{
command! MouseToggle if &mouse=="" | set mouse=a | else | set mouse= | endif

" See the diff between the current buffer and the file on disk.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis

" Cycle colorschemes
command! ColorCycle call <SID>colors_cycle() | colorscheme
" --- Command defs }}}
