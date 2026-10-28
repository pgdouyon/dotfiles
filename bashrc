#!/bin/bash
set -o emacs

shopt -s histappend
shopt -s expand_aliases

stty -ixon

function tmux_backup {
    local backup_dir
    backup_dir="$HOME/tmux-backup/$(date --iso-8601)"
    mkdir -p "$backup_dir"
    for session in $(tmux ls -F "#{session_name}"); do
        echo "Capturing tmux state for session: ${session}"
        for pane in $(tmux list-panes -t "$session" -s -F "#{window_index}.#{pane_index}"); do
            tmux capture-pane -p -t "${session}:${pane}" -S -5000 > "${backup_dir}/${session}-${pane}.txt"
        done
    done
    echo "Finished tmux backup. Capture files saved to: ${backup_dir}"
    ls -la "$backup_dir"
}

function jenv {
    if [[ -x /usr/libexec/java_home ]]; then
        local version
        case $1 in
            # Java 9 and later version strings dropped the 1.X format
            [0-8] ) version="1.$1";;
            * ) version=$1;;
        esac
        if /usr/libexec/java_home -F -v "$version"; then
            export JAVA_VERSION=$version
        fi
    else
        echo 'Cannot find /usr/libexec/java_home executable'
        exit 1
    fi
}

# Private utility functions
function __prompt {
    prompt=${1:-'Do you wish to proceed [yes/no]?'}
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
    return 1
}

function __archive_name {
    printf '%s' "$(basename "$1").tar"
}

function __is_tar_file {
    tar -tvf "$1" &> /dev/null
}

# Public functions
function cdl {
    cd "$@" && ls
}

function cpstat {
    # copy large file directories, recursively, using pv to show a live progress meter
    local estimated_output_size
    # estimated output = rsync headers (~2) + total file count
    estimated_output_size=$((2 + $(find "$1" | wc -l)))
    rsync -vrltD --stats --human-readable "$1" "$2" | pv -lep -s "$estimated_output_size"
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

function __source_if_present {
    # ignore non-constant source check
    # shellcheck disable=SC1090
    [[ -f $1 ]] && source "$1"
}

# XXX bash_completion is slow to load
# __source_if_present "$HOMEBREW_PREFIX"/etc/profile.d/bash_completion.sh
__source_if_present "$HOMEBREW_PREFIX"/etc/profile.d/autojump.sh

__source_if_present ~/.bashrc.local
__source_if_present "$XDG_DATA_HOME/fzf/fzf.bash"
__source_if_present "$XDG_DATA_HOME/git-prompt.sh"
__source_if_present "$XDG_CONFIG_HOME"/bash/aliases
