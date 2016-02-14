let g:alduin_Shout_Windhelm = 1

let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
let g:bufferline_echo = 0
let g:bufferline_rotate = 1
let g:bufferline_fixed_index = 0
let g:bufferline_fname_mod = ':~:.'
let g:bufferline_pathshorten = 1

" --- Lightline options {{{
let g:lightline = {
    \   'colorscheme': 'jellybeans',
    \   'active': {
    \     'left': [
    \       ['mode', 'paste'],
    \       ['fugitive'],
    \       ['bufferinfo'],
    \     ],
    \     'right': [
    \       ['colinfo', 'percent'],
    \       ['filetype'],
    \       ['fileformat']
    \     ]
    \   },
    \   'inactive': {
    \     'left': [ ['bufferinfo'] ],
    \     'right': [ ['percent'], ['filetype'] ]
    \   },
    \   'tab': {
    \     'active': ['tabnum'],
    \     'inactive': ['tabnum']
    \   },
    \   'tabline': {
    \     'left': [ ['tabs'], ['bufferline'] ],
    \     'right': [ ['fileencoding'] ]
    \   },
    \   'component': {
    \     'bufferinfo': '%f %m',
    \     'bufferline': '%{bufferline#refresh_status()}'.
    \                   '%#TabLineSel# %{g:bufferline_status_info.current} '.
    \                   '%#LightLineLeft_tabline_tabsel_1#%{MyBufferlineAfter()}',
    \     'colinfo': ':%c%V',
    \     'paste': '%{&paste?"P":""}'
    \   },
    \   'component_function': {
    \     'fileformat'  : 'MyFileformat',
    \     'filetype'    : 'MyFiletype',
    \     'fileencoding': 'MyFileencoding',
    \     'fugitive'    : 'MyFugitive'
    \   },
    \   'subseparator': {
    \     'left': '|', 'right': '|'
    \   }
    \ }

let g:lightline.enable = {
    \   'statusline': 1,
    \   'tabline': 1
    \ }

let g:lightline.mode_map = {
    \   'n'      : ' N ',
    \   'i'      : ' I ',
    \   'R'      : ' R ',
    \   'v'      : ' V ',
    \   'V'      : 'V-L',
    \   'c'      : ' C ',
    \   "\<C-v>" : 'V-B',
    \   's'      : ' S ',
    \   'S'      : 'S-L',
    \   "\<C-s>" : 'S-B',
    \   "t"      : ' T ',
    \   '?'      : ' ? '
    \ }

function! MyBufferlineAfter()
  let clen = len(g:bufferline_status_info.current)
  let a = ' ' . g:bufferline_status_info.after
  let rlen = 4*tabpagenr('$') + len(MyFileencoding()) + 8
  if &columns > rlen + clen + len(a)
    return a
  else
    let i = &columns - rlen - clen - 3
    return i > 0 ? a[0:i] . '...' : '...'
  endif
endfunction

function! MyFiletype()
  return strlen(&filetype) ? &filetype : '--'
endfunction

function! MyFileformat()
  return winwidth('.') > 80 ? &fileformat : ''
endfunction

function! MyFileencoding()
  return strlen(&fenc) ? &fenc : &enc
endfunction

function! MyFugitive()
  if exists('*fugitive#head') && winwidth('.') > 75
    let bmark = '┣ '
    let branch = fugitive#head()
    return strlen(branch) ? bmark . branch : ''
  endif
  return ''
endfunction
" --- Lightline options }}}

call lexima#add_rule({'char': "'", 'at': '\(&\|<[^>]*\|^\s*\)\%#', 'filetype': 'rust'})

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

let g:unite_source_rec_async_command = 'ag --nocolor --nogroup -g .'

let g:unite_fasd#fasd_path = '~/.zsh/fasd/fasd'
let g:unite_fasd#fasd_cache = '~/.cache/fasd'

let g:viewdoc_openempty = 0
