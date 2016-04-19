#!/bin/bash
set -o emacs

shopt -s expand_aliases

stty -ixon

function cdl {
    cd "$@"; ls
}

function cpstat {
    rsync -vrltD --stats --human-readable "$1" "$2" | pv -lep -s $((2 + $(find "$1" | wc -l)))
}

function check-aliases {
    echo 'Possible alias conflicts...'
    alias | while read alias_line; do
        alias=$(sed 's/alias \([^=]*\).*/\1/' <<< "$alias_line")
        if [[ -n $(which "$alias") ]]; then
            echo "$alias"
        fi
    done
}

function vs {
    session_home="$HOME/vim-sessions/"
    session=$(find "$session_home" -type f -print0 | xargs -0 -n1 basename | fzf)
    nvim -S "${session_home}${session}"
}

if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    source "$(brew --prefix)"/etc/bash_completion
fi

eval "$(fasd --init auto)"
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f $XDG_DATA_HOME/fzf/fzf.bash ]] && source "$XDG_DATA_HOME/fzf/fzf.bash"
[[ -f $XDG_DATA_HOME/git-prompt.sh ]] && source "$XDG_DATA_HOME/git-prompt.sh"
[[ -f $XDG_CONFIG_HOME/bash/aliases ]] && source "$XDG_CONFIG_HOME"/bash/aliases && _fasd_bash_hook_cmd_complete j jj o
