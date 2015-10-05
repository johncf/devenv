filetype plugin indent on
let s:colors_fav = ['desertEx-v2', 'gruvbox', 'apprentice', 'codeschool', 'desert']

function s:colors_cycle()
  let color_next = s:colors_fav[s:colors_idx]
  let s:colors_idx += 1
  let s:colors_idx = s:colors_idx % len(s:colors_fav)
  exe 'colorscheme ' . color_next
endfun

if $TERM == 'linux'
  let s:colors_idx = 4
elseif has("gui_running")
  let s:colors_idx = 1
  set guifont=MonacoB
  set guioptions-=T "toolbar
  set guioptions-=r "scrollbar
  set guioptions-=m "menubar
else
  let s:colors_idx = 0
endif
call s:colors_cycle()
syntax enable

" --- Autocommands {{{
augroup critiq_au
  autocmd!
  autocmd FileType netrw nnoremap <buffer> qq <C-^> | nmap <buffer> <Space> mf
  autocmd FileType qf nnoremap <buffer> qq <C-w>q | setlocal nonu nornu
  autocmd FileType vim\|python setlocal ts=2 sw=2
  autocmd FileType man\|help\|pydoc\|info
      \ if &bt == "nofile" |
      \   nnoremap <buffer> <nowait> d <C-d> |
      \   nnoremap <buffer> <nowait> u <C-u> |
      \ endif
  autocmd WinLeave,InsertEnter * setlocal nocursorline
  autocmd WinEnter,BufEnter * if &g:cursorline | setlocal cursorline | endif
augroup END
" --- Autocommands }}}

" --- Command defs {{{
command! MouseToggle if &mouse=="" | set mouse=a | else | set mouse= | endif

" See the diff between the current buffer and the file on disk.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis

" Cycle colorschemes
command! ColorCycle call <SID>colors_cycle()
" --- Command defs }}}
