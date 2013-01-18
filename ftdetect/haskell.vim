au BufNewFile,BufRead *.hs set filetype=haskell
au BufNewFile,BufRead *.lhs set filetype=haskell
au BufNewFile,BufRead *.elm set filetype=haskell

if has("mac")
else
	let g:haddock_browser="/usr/bin/firefox"
	let g:haddock_docdir="/usr/share/doc/ghc-doc/html/libraries/base-4.5.1.0"
	let g:ghc_pkg="/usr/bin/ghc-pkg"
endif
