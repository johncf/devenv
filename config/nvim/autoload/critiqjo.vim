" Update the undo-file, and quit without saving
function! critiqjo#redoable_zq()
  if &undofile && &modified && expand('%') != ''
    earlier 1f
    exe 'wundo ' . escape(undofile(expand('%')), ' %')
  endif
  q!
endfun

" Try returning to the previously visited buffer, then close
function! critiqjo#buf_close()
  if &modified
    echohl WarningMsg | echom "No write since last change!" | echohl None
    return
  endif
  if getcmdwintype() != '' || len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) <= 1
    q!
  else
    bd!
  endif
endfun

" Get the nth modifiable buffer, relative to the current one if direction=±1,
" or relative to the first modifiable buffer if direction=0
function! critiqjo#get_ma_buf(n, direction)
  let dir = a:direction
  let n = a:n
  let curbufnr = bufnr('%')
  if n == 0 && dir != 0 && &modifiable
    let n = 1
  endif
  let endbufnr = bufnr('$')
  if dir == 0
    let curbufnr = 0
    let dir = 1
  endif
  if dir == -1
    let bufrange = [0] + reverse(range(1, endbufnr - 1))
  else
    let bufrange = range(0, endbufnr - 1)
  endif
  let total = 0
  let mbufs = []
  for bi in bufrange
    let buf = (curbufnr - 1 + bi)%endbufnr + 1
    if buflisted(buf) && getbufvar(buf, "&modifiable")
      if n == len(mbufs)
        return buf
      endif
      let mbufs += [buf]
    endif
  endfor
  if len(mbufs) == 0
    return curbufnr
  else
    return mbufs[n%len(mbufs)]
  endif
endfun

" original src: http://stackoverflow.com/questions/2974192/
function! critiqjo#only_visible()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if buflisted(b) && bufwinnr(b)<1
      let l:tally += 1
      exe 'bd ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

function! critiqjo#unite_dir()
  let path = input('Path: ', expand('%:h'), 'dir')
  if len(path)
    if has('nvim')
      let rec_type = 'neovim'
    else
      let rec_type = 'async'
    endif
    exe 'Unite -start-insert file_rec/' . rec_type . ':' . escape(path, ' ')
  endif
endfun
