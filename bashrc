#!/bin/bash
set -o vi

shopt -s expand_aliases

stty -ixon

function cdl {
    cd "$1"
    ls
}

function cpstat {
    rsync -vrltD --stats --human-readable "$1" "$2" | pv -lep -s $((2 + $(find "$1" | wc -l)))
}

if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    source "$(brew --prefix)"/etc/bash_completion
fi

eval "$(fasd --init auto)"
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f $XDG_DATA_HOME/fzf/fzf.bash ]] && source "$XDG_DATA_HOME/fzf/fzf.bash"
[[ -f $XDG_DATA_HOME/git-prompt.sh ]] && source "$XDG_DATA_HOME/git-prompt.sh"
[[ -f $XDG_CONFIG_HOME/bash/aliases ]] && source "$XDG_CONFIG_HOME"/bash/aliases && _fasd_bash_hook_cmd_complete j jj o
