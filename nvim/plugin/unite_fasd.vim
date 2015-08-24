if !exists('g:unite_fasd#fasd_path')
  echom 'g:unite_fasd#fasd_path not set.'
  finish
endif

if !exists('g:unite_fasd#fasd_cache')
  let g:unite_fasd#fasd_cache = '~/.fasd'
endif

if !exists('g:unite_fasd#viminfo')
  if has('nvim')
    let g:unite_fasd#viminfo = '~/.nviminfo'
  else
    let g:unite_fasd#viminfo = '~/.viminfo'
  endif
endif

if !exists('g:unite_fasd#viminfo_cache')
  let g:unite_fasd#viminfo_cache = tempname()
endif

call system('[ -f ' . g:unite_fasd#viminfo_cache . ' ] || cp ' .
  \ g:unite_fasd#viminfo . ' ' . g:unite_fasd#viminfo_cache)

function s:candidates_from_sh(sh_cmd)
  let cands = []
  for f in split(system(a:sh_cmd), "\n")
    let cands += [{
      \   'word': f,
      \   'kind': 'file',
      \   'action__path': f
      \ }]
  endfor
  return cands
endfun

function! s:mru_candidates(args)
  if exists('s:fasd_mru') && len(s:fasd_mru) && !(len(a:args) && a:args[0] == 'reload')
    return s:fasd_mru
  endif
  echo 'Reloaded!'
  exe 'wviminfo ' . g:unite_fasd#viminfo_cache
  let s:fasd_mru = s:candidates_from_sh('_FASD_DATA=' . g:unite_fasd#fasd_cache . ' _FASD_VIMINFO=' .
    \ g:unite_fasd#viminfo_cache . ' ' . g:unite_fasd#fasd_path . ' -ftRl -B viminfo')
  return s:fasd_mru
endfun

function! s:unite_fasd(args, ctx)
  if len(a:args) && a:args[0] == 'mru'
    return s:mru_candidates(a:args[1:])
  else
    return s:candidates_from_sh('_FASD_DATA=' . g:unite_fasd#fasd_cache . ' _FASD_VIMINFO=' .
      \ g:unite_fasd#viminfo_cache . ' ' . g:unite_fasd#fasd_path . ' -fRl -B viminfo')
  endif
endfun

let fasd_source = {
  \     'name' : 'fasd',
  \     'description' : 'Get candidates from fasd',
  \     'gather_candidates': function('s:unite_fasd')
  \ }

call unite#define_source(fasd_source)

augroup unite_fasd_au
  au!
  au VimLeavePre * exe 'wviminfo ' . g:unite_fasd#viminfo_cache
augroup END
