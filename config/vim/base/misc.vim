filetype plugin indent on

if has("gui_running")
  set guifont=MonacoB
  set guioptions-=T "toolbar
  set guioptions-=r "scrollbar
  set guioptions-=m "menubar
  color desert
elseif $TERM == 'linux'
  color desert
else
  color desertEx-v2
endif
syntax enable

" --- Autocommands {{{
augroup critiq_au
  autocmd!
  autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  autocmd BufRead,BufNewFile *.ll set filetype=llvm
  autocmd FileType netrw nnoremap <buffer> <nowait> q <C-^>
  autocmd FileType qf nnoremap <buffer> <nowait> q <C-w>q | setlocal nonu nornu
  autocmd FileType vim\|pug\|javascript setlocal ts=2 sw=2
  autocmd FileType yaml\|markdown setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType man\|help\|pydoc\|info
      \ if &bt == "nofile" |
      \   nnoremap <buffer> <nowait> d <C-d> |
      \   nnoremap <buffer> <nowait> u <C-u> |
      \ endif
  autocmd BufRead,BufNewFile *CIDE.?,*cide.? setlocal ft=text
augroup END
" --- Autocommands }}}

" --- Command defs {{{
command! MouseToggle if &mouse=="" | set mouse=nvi | else | set mouse= | endif
command! HighlightToggle if &hls==0 | set hls | else | set nohls | endif

" See the diff between the current buffer and the file on disk.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
