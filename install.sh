#!/bin/bash

install_list=".tmux.conf .tmux .vimrc .vim .zshrc .zsh .zinit"

for f in $install_list
do
  rm -rf ~/$f > /dev/null 2>&1
  ln -s ~/dotfiles/$f ~/$f
  echo $f
done
