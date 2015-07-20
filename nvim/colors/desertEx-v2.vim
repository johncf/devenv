" Vim color file
" Maintainer:   Mingbai <mbbill AT gmail DOT com>

set background=dark
set t_Co=256

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="desertEx-v2"

hi Normal       ctermfg=253 ctermbg=234 cterm=NONE

hi ColorColumn              ctermbg=235
hi Cursor       ctermfg=16  ctermbg=226 cterm=NONE
hi CursorLineNr ctermfg=11  ctermbg=233
hi DiffAdd      ctermfg=16  ctermbg=223
hi DiffChange   ctermfg=16  ctermbg=117
hi DiffDelete   ctermfg=16  ctermbg=243 cterm=NONE
hi DiffText     ctermfg=16  ctermbg=205 cterm=NONE
hi ErrorMsg     ctermfg=231 ctermbg=196 cterm=NONE
hi FoldColumn   ctermfg=180 ctermbg=239 cterm=NONE
hi Folded       ctermfg=116 ctermbg=236 cterm=NONE
hi IncSearch    ctermbg=26  ctermfg=159
hi LineNr       ctermfg=144 ctermbg=233 cterm=NONE
  "LineNr       ctermfg=180
hi MatchParen   ctermfg=51              cterm=bold
hi ModeMsg      ctermfg=117             cterm=NONE
hi MoreMsg      ctermfg=29              cterm=NONE
hi NonText      ctermfg=51  ctermbg=236 cterm=NONE
hi Pmenu        ctermfg=231 ctermbg=61  cterm=NONE
hi PmenuSel     ctermfg=61  ctermbg=250
hi Question     ctermfg=48              cterm=NONE
hi Search       ctermfg=252 ctermbg=234 cterm=underline
hi SpecialKey   ctermfg=240             cterm=NONE
hi StatusLine   ctermfg=252 ctermbg=238 cterm=NONE
hi StatusLineNC ctermfg=250 ctermbg=241 cterm=NONE
hi TermCursorNC                         cterm=underline
hi Title        ctermfg=167             cterm=NONE
hi VertSplit    ctermfg=238 ctermbg=238 cterm=NONE
hi Visual       ctermfg=235 ctermbg=215 cterm=NONE
hi WarningMsg   ctermfg=210             cterm=NONE
hi WildMenu     ctermfg=250 ctermbg=235 cterm=NONE

" syntax highlighting groups
hi Comment      ctermfg=114             cterm=NONE
hi Constant     ctermfg=210             cterm=NONE
hi Delimiter    ctermfg=248
  "Delimiter    ctermfg=72
hi Directory    ctermfg=66
hi Identifier   ctermfg=79              cterm=NONE
hi Function     ctermfg=117             cterm=NONE
hi Statement    ctermfg=186             cterm=bold
hi PreProc      ctermfg=211             cterm=NONE
hi Type         ctermfg=215             cterm=bold
hi Special      ctermfg=122             cterm=NONE
hi Ignore       ctermfg=241             cterm=NONE
hi Todo         ctermfg=130 ctermbg=220 cterm=NONE
  "Todo         ctermfg=9

