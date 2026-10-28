#!/bin/bash

# bash prompt
export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]$(__git_ps1 " git:(%s)")\[\033[m\]\$ '

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups

# silence macOS deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

source ~/.profile
source ~/.bashrc
