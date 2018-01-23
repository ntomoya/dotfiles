#!/bin/zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

# Configuration for zplug
source ${HOME}/.zsh/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "tcnksm/docker-alias", use:zshrc
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "themes/agnoster", from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
	print "Install? [y/N]:"
	if read -q; then
		echo; zplug install
	fi
fi

zplug load

# Node.js yarn
if hash yarn 2>/dev/null; then
  export PATH=$(yarn global bin):$PATH
fi


# Go
if [ -e /usr/local/go ]; then
  export PATH=/usr/local/go/bin:$PATH
fi

if hash go 2>/dev/null; then
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH
fi


# Ruby
if [ -e $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
fi

if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi


# Python
if [ -e $HOME/.pyenv ]; then
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH

fi

if hash pyenv 2>/dev/null; then
  eval "$(pyenv init -)"

  if [ -e $(pyenv root)/plugins/pyenv-virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi


case $(uname -a) in
  *Microsoft*)
    source "$HOME/.zsh/.zshrc.wsl"
    ;;
  Linux*)
    source "$HOME/.zsh/.zshrc.linux"
    ;;
  Darwin*)
    source "$HOME/.zsh/.zshrc.osx"
    ;;
esac

if [ ! -e "$HOME/.zsh/.zshrc.env" ]; then
  touch "$HOME/.zsh/.zshrc.env"
fi
source "$HOME/.zsh/.zshrc.env"
