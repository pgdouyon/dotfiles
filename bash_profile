#!/bin/bash

# color term
export CLICOLOR=1

# bash prompt
export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]$(__git_ps1 " git:(%s)")\[\033[m\]\$ '

export FZF_DEFAULT_COMMAND='ag -l -g ""'

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups

# silence macOS deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

source ~/.profile
source ~/.bashrc

if (command -v figlet &>/dev/null) && (command -v cowsay &>/dev/null); then
    echo 'Meikyo Shisui|Chita! Gen Imilite|Pran pasyans|Konsantre!' | tr '|' '\n' | sort --random-sort | head -n1 | figlet -w120 | cowsay -fdaemon -n
fi
