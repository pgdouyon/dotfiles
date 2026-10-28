#!/usr/bin/env zsh

export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS   # deduplicate in memory
setopt HIST_FIND_NO_DUPS      # deduplicate when navigating with ↑ / Ctrl-R
setopt HIST_SAVE_NO_DUPS

source ~/.profile
