#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zinit light zdharma-continuum/fast-syntax-highlighting

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet PZTM::helper

zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
if [ $(date +'%j') != $(date -r ${ZDOTDIR:-$HOME}/.zcompdump +'%j') ]; then
  compinit
else
  compinit -C
fi

# search history
alias hg="history -E 1 | grep"

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

ex () {
  local directory=true
  while [[ $# -gt 0 ]]; do
    case $1 in
      -n | --no-directory)
        directory=false
        shift
        ;;
      -*)
        echo "Unknown option: $1"
        return 1
        ;;
      *)
        break
        ;;
    esac
  done

  if [[ -z "$1" ]]; then
    echo "Usage: extract [-n] <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    return 1
  fi

  local file="$1"
  local base="${file%%.*}"
  local target="$PWD"

  if [[ ! -f $file ]]; then
    echo "$1 - file does not exist"
    return 1
  fi

  if [[ $directory == true ]]; then
    mkdir -p -- "$base" || return 1
    target="$PWD/$base"
  fi

  case $file in
    *.tar.bz2 | *.tbz2)
      tar xvjf "$file" -C "$target"
      ;;
    *.tar.gz | *.tgz)
      tar xvzf "$file" -C "$target"
      ;;
    *.tar.xz | *.txz)
      tar xvJf "$file" -C "$target"
      ;;
    *.lzma)
      unlzma "$file"
      ;;
    *.bz2)
      bunzip2 "$file"
      ;;
    *.rar)
      unrar x -ad "$file" "$target"
      ;;
    *.gz)
      gunzip "$file"
      ;;
    *.tar)
      tar xvf "$file" -C "$target"
      ;;
    *.zip)
      unzip "$file" -d "$target"
      ;;
    *.Z)
      uncompress $file
      ;;
    *.7z)
      7z x "$file" "-o$target"
      ;;
    *.xz)
      unxz "$file"
      ;;
    *.exe)
      cabextract "$file" -d "$target"
      ;;
    *)
      echo "extract: '$file' - unknown archive method"
      ;;
  esac
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
