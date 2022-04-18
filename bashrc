#!/bin/bash
set -o emacs

shopt -s histappend
shopt -s expand_aliases

stty -ixon

function orgflowy {
    case $# in
        0) nvim -c "NifflerOrgFlowy" ;;
        1) nvim -c "OrgFlowy $1" ;;
        *) __error 'Usage: orgflowy [NOTE_NAME]' ;;
    esac
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
    fi
}

# Public functions
function cdl {
    cd "$@" && ls
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

function __source_if_present {
    # ignore non-constant source check
    # shellcheck disable=SC1090
    [[ -f $1 ]] && source "$1"
}

# XXX bash_completion is slow to load
# __source_if_present "$HOMEBREW_PREFIX"/etc/bash_completion
__source_if_present "$HOMEBREW_PREFIX"/etc/profile.d/autojump.sh

__source_if_present ~/.bashrc.local
__source_if_present "$XDG_DATA_HOME/fzf/fzf.bash"
__source_if_present "$XDG_DATA_HOME/git-prompt.sh"
__source_if_present "$XDG_CONFIG_HOME"/bash/aliases
