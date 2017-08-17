#!/bin/zsh

case ${OSTYPE} in
  darwin*)
    source "$HOME/.zsh/.zshrc.osx"
    ;;
  linux*)
    source "$HOME/.zsh/.zshrc.linux"
    ;;
esac
