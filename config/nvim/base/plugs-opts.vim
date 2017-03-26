let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
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
    \     'bufferline': '%{MyBufferlineRefresh()}'.bufferline#get_status_string('TabLineSel', 'LightLineLeft_tabline_tabsel_1'),
    \     'colinfo': ':%c%V',
    \     'fileencoding': '%{&fenc}',
    \     'paste': '%{&paste?"P":""}'
    \   },
    \   'component_function': {
    \     'fileformat'  : 'MyFileformat',
    \     'filetype'    : 'MyFiletype',
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

function! MyBufferlineRefresh()
  call bufferline#refresh_status()
  let rlen = 4*tabpagenr('$') + len(&fenc) + 8
  call bufferline#trim_status_info(&columns - rlen)
  return ''
endfunction

function! MyFiletype()
  return strlen(&filetype) ? &filetype : '--'
endfunction

function! MyFileformat()
  return winwidth('.') > 80 ? &fileformat : ''
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

let g:table_mode_corner = '|'

let g:viewdoc_openempty = 0

let g:AutoPairsShortcutFastWrap = '<M-s>'
let g:AutoPairsShortcutBackInsert = '<M-u>'
