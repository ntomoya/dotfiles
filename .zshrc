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

# Configuration for zinit
source ${HOME}/.zinit/bin/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

zinit ice pick"init.sh"
zinit light b4b4r07/enhancd

# Load OMZ Git library
zinit snippet OMZ::lib/git.zsh
# Load Git plugin from OMZ
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q # <- forget completions provided up to this moment
setopt promptsubst
# Load theme from OMZ
zinit snippet OMZ::themes/agnoster.zsh-theme

zinit ice svn
zinit snippet PZT::modules/docker


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
