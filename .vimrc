if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein/bundle/')
  call dein#begin('~/.vim/dein/bundle')

  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('fatih/vim-go')
  call dein#add('scrooloose/syntastic')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

set expandtab
set tabstop=2
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set number
set visualbell
syntax on
set term=xterm-256color
set background=dark
