" Vim syntax file
" Language:	Nanoc Markdown

" Read the HTML syntax to start with
runtime! syntax/markdown.vim
unlet! b:current_syntax

syn region erbBlock start=/<%=/ end=/%>/
" YAML region
syn region yamlBlock start=/-----/ end=/-----/
syn region codeBlock start=/<code/ end=/<\/code>/
hi def link yamlBlock Comment
hi def link codeBlock Special

syn match ylang "^..: "
hi def link ylang Comment
syn match yfrlang "^fr: "
hi def link yfrlang PreProc
let b:current_syntax = "ymkd"
