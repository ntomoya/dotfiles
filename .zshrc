# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# history 
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
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

zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit ice svn

autoload -Uz compinit
compinit

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
