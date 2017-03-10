#!/bin/bash
set -o emacs

shopt -s histappend
shopt -s expand_aliases

stty -ixon

# Private utility functions
function __prompt {
    prompt=${1:-"Do you wish to proceed [yes/no]?"}
    while true; do
        read -p "$prompt" response
        case $response in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function __error {
    echo "$@" 1>&2
}

function __archive_name {
    printf '%s' "$(basename "$1").tar"
}

function __is_tar_file {
    tar -tvf "$1" &> /dev/null
}

function __gpg {
    if command -v gpg2 &>/dev/null; then
        gpg2 "$@"
    elif command -v gnupg2 &>/dev/null; then
        gnupg2 "$@"
    elif command -v gpg &>/dev/null; then
        gpg "$@"
    elif command -v gnupg &>/dev/null; then
        gnupg "$@"
    else
        __error 'Unable to locate GPG program. Aborting...'
        exit 1
    fi
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
    [[ -n $session ]] && nvim -S "${session_home}${session}"
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

function encrypt {
    if ! command -v pbpaste &>/dev/null; then
        echo 'pbpaste command required. Aborting...'
        return 1
    elif (( $# == 0 )); then
        echo 'Usage: encrypt FILE...'
        return 2
    fi
    echo "Please copy passphrase to the system clipboard."
    if __prompt "Are you ready to continue [yes/no]?"; then
        for target in "$@"; do
            if [[ -d $target ]]; then
                archive "$target"
                target=$(__archive_name "$target")
            fi
            if __gpg --batch --symmetric --passphrase "$(pbpaste)" "$target"; then
                rm -f "$target"
            fi
        done
    fi
}

function decrypt {
    if ! command -v pbpaste &>/dev/null; then
        echo 'pbpaste command required. Aborting...'
        return 1
    elif (( $# == 0 )); then
        echo 'Usage: decrypt FILE...'
        return 2
    fi
    echo "Please copy passphrase to the system clipboard."
    if __prompt "Are you ready to continue [yes/no]?"; then
        for gpg_file in "$@"; do
            local decrypted_file
            decrypted_file=$(sed 's/\.gpg$//' <<< "$gpg_file")

            if __gpg --batch --passphrase "$(pbpaste)" "$gpg_file"; then
                if __is_tar_file "$decrypted_file"; then
                    unarchive "$decrypted_file"
                fi
            fi
        done
    fi
}

if [[ -f $HOMEBREW_HOME/etc/bash_completion ]]; then
    source "$HOMEBREW_HOME"/etc/bash_completion
fi

eval "$(fasd --init auto)"
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f $XDG_DATA_HOME/fzf/fzf.bash ]] && source "$XDG_DATA_HOME/fzf/fzf.bash"
[[ -f $XDG_DATA_HOME/git-prompt.sh ]] && source "$XDG_DATA_HOME/git-prompt.sh"
[[ -f $XDG_CONFIG_HOME/bash/aliases ]] && source "$XDG_CONFIG_HOME"/bash/aliases && _fasd_bash_hook_cmd_complete j jj o
