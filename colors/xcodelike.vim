" =============================================================================
" Name: xcodelike
" Purpose: XCode-like colour scheme
" Maintainer: Kazufumi Tomori (kaz6120@gmail.com)
" @since  : 9.4.11
" @version: 9.4.12
" =============================================================================

set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "xcodelike"
  
" =============================================================================
" Vim >= 7.0 specific colours
" =============================================================================

if version >= 700
  hi CursorLine   guibg=#2d2d2d
  hi CursorColumn guibg=#2d2d2d
  hi MatchParen   guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu 	  guifg=#f6f3e8 guibg=#444444
  hi PmenuSel 	  guifg=#000000 guibg=#A90D91
endif

" =============================================================================
" General colours
" =============================================================================
hi Cursor       guifg=#ffffff guibg=#000000 gui=none
hi Normal       guifg=#000000 guibg=#ffffff gui=none   "Text
hi NonText      guifg=#000000 guibg=#ffffff gui=none   "Background
hi LineNr       guifg=#666666 guibg=#eeeeee gui=none   "Line Number
hi StatusLine   guifg=#eeeeee guibg=#444444 gui=italic
hi StatusLineNC guifg=#666666 guibg=#eeeeee gui=none
hi VertSplit    guifg=#eeeeee guibg=#444444 gui=none   "Vertical Split Line
hi Folded       guibg=#384048 guifg=#a0a8b0 gui=none
" Y - Modification de la couleur du Title (presque blanc avant)
hi Title        guifg=#307430 guibg=NONE    gui=bold
hi Visual       guifg=#000000 guibg=#B2D5FF gui=none   "Selection
hi SpecialKey   guifg=#3875d7 guibg=#B2D5FF gui=none

" =============================================================================
" Syntax highlighting
" =============================================================================
hi Comment      guifg=#007400 gui=italic "Comments
hi Todo         guifg=#8f8f8f gui=italic
hi Constant     guifg=#2E0D6D gui=none   "Constants
hi String       guifg=#C41A15 gui=none   "text string value 
hi Identifier   guifg=#996633 gui=none   "variable value
hi Function     guifg=#5B2599 gui=none   "PHP buit-in functions #826B28
hi Type         guifg=#D66801 gui=none   "class, public, self, array(), -> sign,
hi Statement    guifg=#A90D91 gui=none   "variable $ sign, if-else statement,
hi Keyword      guifg=#a91301 gui=none   "Unknown
hi PreProc      guifg=#A90D91 gui=none   "Unknown
hi Number       guifg=#1C00CE gui=none   "Numbers
hi Special      guifg=#3E6D74 gui=none   "{ } braces, (darker:#25464A)
hi Search       guifg=#FF0000 guibg=#ffff00 "Search hilighted text (darker:#f0e200)
