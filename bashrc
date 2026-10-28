#!/usr/bin/env bash
shopt -s histappend
shopt -s expand_aliases

source ~/.shared-rc

# XXX bash_completion is slow to load
# __source_if_present "$HOMEBREW_PREFIX"/etc/profile.d/bash_completion.sh
__source_if_present ~/.bashrc.local
__source_if_present "$XDG_DATA_HOME/fzf/fzf.bash"
