#!/bin/bash
set -o emacs

shopt -s expand_aliases

stty -ixon

# Private utility functions
function __archive_name {
    printf '%s' "$(basename "$1").tar"
}

# Public functions
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

function archive {
    for file in "$@"; do
        local archive_name
        archive_name=$(__archive_name "$file")
        if tar -cvf "$archive_name" "$file"; then
            rm -rf "$file"
        fi
    done
}

function unarchive {
    for tar_file in "$@"; do
        if tar -xvf "$tar_file"; then
            rm -rf "$tar_file"
        fi
    done
}

if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    source "$(brew --prefix)"/etc/bash_completion
fi

eval "$(fasd --init auto)"
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f $XDG_DATA_HOME/fzf/fzf.bash ]] && source "$XDG_DATA_HOME/fzf/fzf.bash"
[[ -f $XDG_DATA_HOME/git-prompt.sh ]] && source "$XDG_DATA_HOME/git-prompt.sh"
[[ -f $XDG_CONFIG_HOME/bash/aliases ]] && source "$XDG_CONFIG_HOME"/bash/aliases && _fasd_bash_hook_cmd_complete j jj o
