#!/bin/zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

# Configuration for zplugin
source ${HOME}/.zplugin/bin/zplugin.zsh

zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light zdharma/fast-syntax-highlighting
# Load OMZ Git library
zplugin snippet OMZ::lib/git.zsh
# Load Git plugin from OMZ
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q # <- forget completions provided up to this moment
setopt promptsubst
# Load theme from OMZ
zplugin snippet OMZ::themes/agnoster.zsh-theme

zplugin ice svn
zplugin snippet PZT::modules/docker

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
# lazy loading
rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}


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
