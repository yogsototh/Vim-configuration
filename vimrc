" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Mar 29
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set background=dark "I'm on black background on ubuntu
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=10000	" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" color theme zenburn both on gui and standard
colorscheme zenburn

if version>540
    autocmd!
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  " set binary mode before reading the file
  autocmd BufReadPre,FileReadPre	*.gz,*.bz2 set bin
  autocmd BufReadPost,FileReadPost	*.gz call GZIP_read("gunzip")
  autocmd BufReadPost,FileReadPost	*.bz2 call GZIP_read("bunzip2")
  autocmd BufWritePost,FileWritePost	*.gz call GZIP_write("gzip")
  autocmd BufWritePost,FileWritePost	*.bz2 call GZIP_write("bzip2")
  autocmd FileAppendPre			*.gz call GZIP_appre("gunzip")
  autocmd FileAppendPre			*.bz2 call GZIP_appre("bunzip2")
  autocmd FileAppendPost		*.gz call GZIP_write("gzip")
  autocmd FileAppendPost		*.bz2 call GZIP_write("bzip2")

  " After reading compressed file: Uncompress text in buffer with "cmd"
  fun! GZIP_read(cmd)
    " set 'cmdheight' to two, to avoid the hit-return prompt
    let ch_save = &ch
    set ch=3
    " when filtering the whole buffer, it will become empty
    let empty = line("'[") == 1 && line("']") == line("$")
    let tmp = tempname()
    let tmpe = tmp . "." . expand("<afile>:e")
    " write the just read lines to a temp file "'[,']w tmp.gz"
    execute "'[,']w " . tmpe
    " uncompress the temp file "!gunzip tmp.gz"
    execute "!" . a:cmd . " " . tmpe
    " delete the compressed lines
    '[,']d
    " read in the uncompressed lines "'[-1r tmp"
    set nobin
    execute "'[-1r " . tmp
    " if buffer became empty, delete trailing blank line
    if empty
      normal Gdd''
    endif
    " delete the temp file
    call delete(tmp)
    let &ch = ch_save
    " When uncompressed the whole buffer, do autocommands
    if empty
      execute ":doautocmd BufReadPost " . expand("%:r")
    endif
  endfun

  " After writing compressed file: Compress written file with "cmd"
  fun! GZIP_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "!" . a:cmd . " <afile>:r"
    endif
  endfun

  " Before appending to compressed file: Uncompress file with "cmd"
  fun! GZIP_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")

" encodages des fichiers
set enc=utf-8
" encodage des fontes du terminal
"set tenc=latin-1
set termencoding=utf-8

" gestion des tabulations
set tabstop=4
set shiftwidth=4
set expandtab

" recherche incrementale
set incsearch
set autoindent
syntax on;
set gfn=Monospace\ 9
set term=xterm-color

" formatage (une seule ligne mais de coupure au milieu des mots)
set wrap
set showbreak=...\ 
set linebreak
map j gj
map k gk

" Par defaut on active l'indentation auto
:filetype indent on
" Par defaut on active les plugins
:filetype plugin on
" Formatage des XML automatiquement quand on appuie sur F2
map <F2> <Esc>:%!xmllint --format -<CR>

" syntax folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
set t_Co=256

" Syntax pour markdown (bluecloth)
augroup mkd
    autocmd BufRead *.mkd set ai foratoptions=tcroqn2 comments=n:>
augroup END

" correction orthographique
if has("spell")
    " Les dictionnaires seront telecharges automatiquement si le repertoire ~/.vim/spell existe
    if !filewritable($HOME."/.vim/spell")
        call mkdir($HOME."/.vim/spell", "p")
    endif
    set spellsuggest=10 " La commande z= affiche des suggestions, je n'en veux que 10 pour ne pas surcharger l'écran
    " On regle les touches d'activation manuelle de la correction orthographique
    noremap ,sf :setlocal spell spelllang=fr <CR>
    noremap ,se :setlocal spell spelllang=en <CR>
    noremap ,sn :setlocal nospell <CR>
    " On active automatiquement le mode spell pour les fichiers texte et LaTeX
    autocmd BufEnter *.txt,*.tex,*.html,*.md,*.ymd setlocal spell
    autocmd BufEnter *.txt,*.tex,*.html,*.md,*.ymd setlocal spelllang=fr,en
    " colorisation du la correction orthographique
   highlight clear SpellBad
   highlight SpellBad term=standout ctermfg=2 term=underline cterm=underline
   highlight clear SpellCap
   highlight SpellCap term=underline cterm=underline
   highlight clear SpellRare
   highlight SpellRare term=underline cterm=underline
   highlight clear SpellLocal
   highlight SpellLocal term=underline cterm=underline
endif

:iab czsh <div><code class="zsh"><CR>$<CR></code></div><Esc>kA

function! YMarkDown()
    set foldenable
    set foldlevel=0
    set foldminlines=0
    set foldmethod=expr
    set foldtext=''
    set scrollbind
    set foldexpr=getline(v:lnum)=~'^en:\ .*$'
    vsplit  
    set foldexpr=getline(v:lnum)=~'^fr:\ .*$'
    set spell
endfunction

autocmd BufRead *latest.md  call YMarkDown()

" Couleur pour Objective-J
autocmd BufReadPre,FileReadPre *.j set ft=objj

" XCODE "

" update the :make command to tell Xcode to build
set makeprg=osascript\ -e\ \"tell\ application\ \\\"Xcode\\\"\"\ -e\ \"build\"\ -e\ \"end\ tell\"

function! XcodeClean()
         silent execute ':!osascript -e "tell application \"Xcode\"" -e "Clean" -e "end tell"'
endfunction
command! -complete=command XcodeClean call XcodeClean()

function! XcodeDebug()
        silent execute '!osascript -e "tell application \"Xcode\"" -e "Debug" -e "end tell"'
endfunction
command! -complete=command XcodeDebug call XcodeDebug()

" Command-K cleans the project
:noremap <D-k> :XcodeClean<CR>
" Command-Return Starts the program in the debugger
:noremap <D-CR> :XcodeDebug<CR>

:inoremap kj <ESC>
 
" Change cursor color for mode 
"if &term =~ "xterm\\|rxvt"
"    " use an orange cursor in insert mode
"    let &t_SI = "\<Esc>]12;orange\x7"
"    " use a red cursor otherwise
"    let &t_EI = "\<Esc>]12;white\x7"
"    silent !echo -ne "\033]12;white\007"
"    " reset cursor when vim exits
"    autocmd VimLeave * silent !echo -ne "\033]12;white\007"
"    " use \003]12;gray\007 for gnome-terminal
"endif

" Haskell
if has("gui_running")
    au BufEnter *.hs compiler ghc
    " Configure browser for haskell_doc.vim
endif
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin"
        let g:haddock_browser = "open"
        let g:haddock_browser_callformat = "%s %s"
    else
        let g:haddock_browser = "/usr/bin/firefox"
        let g:haddock_browser_callformat = "%s %s"
    endif
endif
