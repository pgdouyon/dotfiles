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
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases && _fasd_bash_hook_cmd_complete v vv vm j jj o
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
