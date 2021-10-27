#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# history 
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history

# use emacs keybind
bindkey -e

# no beep
setopt no_beep

# Load zinit
source ${HOME}/.zinit/bin/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
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

autoload -Uz compinit
if [ $(date +'%j') != $(date -r ${ZDOTDIR:-$HOME}/.zcompdump +'%j') ]; then
  compinit
else
  compinit -C
fi

# execute ls when current directory changed
chpwd () {
  ls --color
}

# an alias for ssh port forwarding
# $ fssh hostname 8090 8080 # forwarding remote hostname's 8090 to 8080
# $ fssh hostname 8080      # forwarding remote hostname's 8080 to 8080
fssh () {
  if [ $# -lt 2 ]; then
    echo "Usage: fssh <remote> <port>"
    return 1
  fi

  local host=$1
  local rport=$2
  local lport=$3
  if [[ -z $lport ]]; then
    lport=$2
  fi

  echo "forwarding ${host}:${rport} to localhost:${lport}"
  ssh -L "${lport}:localhost:${rport}" -C -N "${host}"
}

case $(uname -a) in
  *Microsoft*) # WSL1
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
