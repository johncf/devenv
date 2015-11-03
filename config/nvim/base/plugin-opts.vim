if $TERM != 'linux'
  let g:airline_powerline_fonts = 1
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline_theme = 'bubblegum'
"alttheme: 'powerlineish' "hi VertSplit ctermfg=233 ctermbg=233 cterm=NONE

let g:unite_source_rec_async_command = 'ag --nocolor --nogroup -g .'

let g:unite_fasd#fasd_path = '~/.zsh/fasd/fasd'
let g:unite_fasd#fasd_cache = '~/.cache/fasd'

let g:viewdoc_openempty = 0

" --- Quick-scope options {{{
" source: https://gist.github.com/cszentkiralyi/dc61ee28ab81d23a67aa
let g:qs_enable = 0

function! s:qs_selective(movement)
  let needs_disabling = 0
  if !g:qs_enable
    QuickScopeToggle
    redraw
    let needs_disabling = 1
  endif
  let letter = nr2char(getchar())
  if needs_disabling
    QuickScopeToggle
  endif
  return a:movement . letter
endfun

for i in [ 'f', 'F', 't', 'T' ]
  execute 'noremap <expr> <silent>' . i . " <SID>qs_selective('". i . "')"
endfor
" --- Quick-scope options }}}
