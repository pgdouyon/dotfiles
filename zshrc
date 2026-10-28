#!/usr/bin/env zsh

source ~/.shared-rc

setopt PROMPT_SUBST
export PS1='%F{cyan}%n%f@%F{green}%m%f:%B%F{yellow}%~%F{magenta}$(__git_ps1 " git:(%s)")%f%b%(!.#.$) '

__source_if_present ~/.zshrc.local
__source_if_present "$XDG_DATA_HOME/fzf/fzf.zsh"
