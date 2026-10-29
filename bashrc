#!/usr/bin/env bash
shopt -s histappend
shopt -s expand_aliases

# bash prompt
export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]$(__git_ps1 " git:(%s)")\[\033[m\]\$ '

source ~/.shared-rc

# XXX bash_completion is slow to load
# __source_if_present "$HOMEBREW_PREFIX"/etc/profile.d/bash_completion.sh
__source_if_present ~/.bashrc.local
__source_if_present "$XDG_DATA_HOME/fzf/fzf.bash"
