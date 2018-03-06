" Vim color file
" Maintainer:	Kasama
" Last Change:	2016 Oct 24

" kasama -- My personal theme based on darkblue

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "kasama"

"hi Normal		guifg=#c0c0c0 guibg=#000040						ctermfg=gray ctermbg=black
hi Normal		guifg=#a2a2a2 guibg=#282828						ctermfg=gray ctermbg=black
"hi Normal		guifg=gray guibg=black						ctermfg=gray ctermbg=black
"hi Normal		guifg=#31363B guibg=#31363B						ctermfg=gray ctermbg=black
hi ErrorMsg		guifg=#287eff guibg=#d02523						ctermfg=lightblue ctermbg=red
hi Visual		guifg=#8080ff guibg=fg		gui=reverse				ctermfg=darkblue ctermbg=fg cterm=reverse
hi Todo			guifg=#b0ffff guibg=#d14a14						ctermfg=white	ctermbg=brown
hi Search		guifg=#90fff0 guibg=#2050d0						ctermfg=darkblue ctermbg=gray cterm=underline term=underline
hi IncSearch	guifg=#b0ffff guibg=#2050d0							ctermfg=darkblue ctermbg=gray
hi ExtraWhiteSpaces	guifg=#2050d0 guibg=#b0ffff					 ctermfg=darkblue ctermbg=gray

hi SpecialKey		guifg=cyan			ctermfg=darkcyan
hi Directory		guifg=cyan			ctermfg=cyan
hi Title			guifg=magenta gui=none ctermfg=magenta cterm=bold
hi WarningMsg		guifg=red			ctermfg=red
hi WildMenu			guifg=yellow guibg=black ctermfg=lightgray ctermbg=darkgrey cterm=none term=none
hi ModeMsg			guifg=#22cce2		ctermfg=lightblue
hi MoreMsg			ctermfg=darkgreen	ctermfg=darkgreen
hi Question			guifg=green gui=none ctermfg=green cterm=none
hi NonText			guifg=#0030ff		ctermfg=darkblue

hi StatusLine	guifg=blue guibg=darkgray gui=none		ctermfg=black ctermbg=darkmagenta term=none cterm=none
hi StatusLineNC	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none
hi VertSplit	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none

hi Folded	guifg=#808080 guibg=#000040			ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi FoldColumn	guifg=#808080 guibg=#000040			ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi LineNr	guifg=#90f020			ctermfg=green cterm=none

hi DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

hi Cursor	guifg=black guibg=yellow ctermfg=black ctermbg=yellow
hi lCursor	guifg=black guibg=white ctermfg=black ctermbg=white


hi Comment	guifg=#80a0ff ctermfg=lightblue
hi Constant	ctermfg=magenta guifg=#ffa0a0 cterm=none
hi Special	ctermfg=brown guifg=Orange cterm=none gui=none
hi Identifier	ctermfg=cyan guifg=#40ffff cterm=none
hi Statement	ctermfg=yellow cterm=none guifg=#ffff60 gui=none
hi PreProc	ctermfg=magenta guifg=#ff80ff gui=none cterm=none
hi type		ctermfg=green guifg=#60ff60 gui=none cterm=none
hi Underlined	cterm=underline term=underline
hi Ignore	guifg=bg ctermfg=bg

" suggested by tigmoid, 2008 Jul 18
hi Pmenu guifg=#c0c0c0 guibg=#404080
hi PmenuSel guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c0c0
