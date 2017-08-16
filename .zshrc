export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:/opt/android-sdk/platform-tools
export PATH=$PATH:/home/tomoya/.config/yarn/global/node_modules/.bin
export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tomoya/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
set -o vi

# Configuration for zplug
source /usr/share/zsh/scripts/zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "tcnksm/docker-alias", use:zshrc
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "themes/agnoster", from:oh-my-zsh, as:theme

if ! zplug check --verbose; then
	print "Install? [y/N]:"
	if read -q; then
		echo; zplug install
	fi
fi

zplug load
