""""""""""""""""""""
" Vundle
""""""""""""""""""""
set nocompatible
"filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Look and feel
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'

" Git
Bundle 'gregsexton/gitv'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'

" Code style
Bundle 'bitc/vim-bad-whitespace'
Bundle 'ciaranm/detectindent'
Bundle 'nathanaelkane/vim-indent-guides'

" Navigation
Bundle 'ZoomWin'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'majutsushi/tagbar'
Bundle 'milkypostman/vim-togglelist'
Bundle 'scrooloose/nerdtree'

" Shortcuts
Bundle 'Raimondi/delimitMate'
Bundle 'nevillelyh/snipmate.vim'
Bundle 'scrooloose/nerdcommenter'
if v:version < 703 || !has( 'patch584' )
    Bundle 'ervandew/supertab'
else
    Bundle 'Valloric/YouCompleteMe'
endif

" Syntax check
Bundle 'scrooloose/syntastic'
Bundle 'tmhedberg/SimpylFold'

" Syntax support
Bundle 'derekwyatt/vim-scala'
Bundle 'framallo/asciidoc.vim'
Bundle 'jboyens/vim-protobuf'
Bundle 'jnwhiteh/vim-golang'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-scripts/VimClojure'
Bundle 'vim-scripts/google.vim'

filetype plugin indent on
syntax on
