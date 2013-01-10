# Vim configuration

This is my personnal .vim folder and my vimrc file.

Just remember to copy the vimrc file to your $HOME/.vimrc

## For vimproc

- Windows using Mingw(32bit Vim): `$ make -f make_mingw32.mak`
- Windows using Mingw(64bit Vim): `$ make -f make_mingw64.mak`
- Windows using Visual Studio(32bit/64bit Vim): $` nmake -f Make_msvc.mak nodebug=1`
- Mac OS X using LLVM: $` make -f make_mac.mak`
- Old Mac OS X(llvm-gcc is not installed): `$ make -f make_mac_old.mak`
- Linux/BSD: `$ make -f make_unix.mak`
- Cygwin: `$ make -f make_cygwin.mak`
- Solaris/Sun OS: `$ make -f make_sunos.mak`

## For Haskell plugins to work properly

~~~
cabal install ghc-mod
~~~

