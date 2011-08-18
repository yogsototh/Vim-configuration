" Vim syntax file
" Language:	Nanoc Markdown

" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlBold     start=/\\\@<!\(^\|\A\)\@=\*\@<!\*\*\*\@!/     end=/\\\@<!\*\@<!\*\*\*\@!\($\|\A\)\@=/   contains=@Spell,htmlItalic
syn region htmlItalic   start=/\\\@<!\(^\|\A\)\@=\*\@<!\*\*\@!/       end=/\\\@<!\*\@<!\*\*\@!\($\|\A\)\@=/      contains=htmlBold,@Spell
syn region htmlBold     start=/\\\@<!\(^\|\A\)\@=_\@<!___\@!/         end=/\\\@<!_\@<!___\@!\($\|\A\)\@=/       contains=htmlItalic,@Spell
syn region htmlItalic   start=/\\\@<!\(^\|\A\)\@=_\@<!__\@!/          end=/\\\@<!_\@<!__\@!\($\|\A\)\@=/        contains=htmlBold,@Spell

" [link](URL) | [link][id] | [link][]
syn region mkdLink matchgroup=mkdDelimiter      start="\!\?\[" end="\]\ze\s*[[(]" contains=@Spell nextgroup=mkdURL,mkdID skipwhite oneline
syn region mkdID matchgroup=mkdDelimiter        start="\["    end="\]" contained
syn region mkdURL matchgroup=mkdDelimiter       start="("     end=")"  contained

" Link definitions: [id]: URL (Optional Title)
" TODO handle automatic links without colliding with htmlTag (<URL>)
syn region mkdLinkDef matchgroup=mkdDelimiter   start="^ \{,3}\zs\[" end="]:" oneline nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkFootnoteDef matchgroup=mkdDelimiter   start="^ \{,3}\zs\[\^" end="]:" 
syn region mkdLinkDefTarget start="<\?\zs\S" excludenl end="\ze[>[:space:]\n]"   contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+"+     end=+"+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+'+     end=+'+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+(+     end=+)+  contained

"define Markdown groups
syn match  mkdLineContinue ".$" contained
syn match  mkdRule      /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule      /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule      /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule      /^\s*-\{3,}$/
syn match  mkdRule      /^\s*\*\{3,5}$/
syn match  mkdListItem  "^\s*[-*+]\s\+"
syn match  mkdListItem  "^\s*\d\+\.\s\+"
syn match  mkdCode      /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/
syn match  mkdLineBreak /  \+$/
syn region mkdCode      start=/\\\@<!`/                   end=/\\\@<!`/
syn region mkdCode      start=/\s*``[^`]*/          end=/[^`]*``\s*/
syn region mkdBlockquote start=/^\s*>/              end=/$/                 contains=mkdLineBreak,mkdLineContinue,@Spell
syn region mkdCode      start="<pre[^>]*>"         end="</pre>"
syn region mkdCode      start="<code[^>]*>"        end="</code>"

"HTML headings
syn region htmlH1       start="\s*#"                   end="\($\|#\+\)" contains=@Spell
syn region htmlH2       start="\s*##"                  end="\($\|#\+\)" contains=@Spell
syn region htmlH3       start="\s*###"                 end="\($\|#\+\)" contains=@Spell
syn region htmlH4       start="\s*####"                end="\($\|#\+\)" contains=@Spell
syn region htmlH5       start="\s*#####"               end="\($\|#\+\)" contains=@Spell
syn region htmlH6       start="\s*######"              end="\($\|#\+\)" contains=@Spell

" YAML region
syn region yamlBlock start=/-----/ end=/-----/
HtmlHiLink yamlBlock Comment
syn match  yfrench  /^fr: /
syn match  yenglish /^en: /
" fr: and en: 
"highlighting for Markdown groups
HtmlHiLink mkdString	    String
HtmlHiLink mkdCode          String
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Todo
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkFootnoteDef mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString

HtmlHiLink mkdDelimiter     Delimiter

HtmlHiLink yfrench Identifier
HtmlHiLink yenglish Identifier


let b:current_syntax = "mkd"

delcommand HtmlHiLink
" vim: ts=8
