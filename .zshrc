#!/bin/zsh

case ${OSTYPE} in
  darwin*)
    ;;
  linux*)
    source "$HOME/.zsh/.zshrc.linux"
    ;;
esac
