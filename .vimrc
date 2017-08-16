if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein/bundle/')
  call dein#begin('~/.vim/dein/bundle')

  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-endwise')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ctrlpvim/ctrlp.vim')

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
set background=dark
colorscheme solarized

let g:airline_solarized_bg='dark'
