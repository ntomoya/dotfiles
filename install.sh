#!/bin/bash

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitmodules" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue


  echo "$f"
  ln -s ~/dotfiles/"$f" ~/"$f"
done
