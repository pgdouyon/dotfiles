#!/bin/sh
export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo

if [ -x /usr/libexec/path_helper ]; then
    export PATH=""
    eval "$(/usr/libexec/path_helper -s)"
fi

if [ -z "$TMUX" ]; then
    if toe -a | grep xterm-256color-italic >/dev/null ; then
        export TERM=xterm-256color-italic
    else
        export TERM=xterm-256color
    fi
fi

if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -n "$HOMEBREW_PREFIX" ]; then
    export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Applications --caskroom=${HOMEBREW_PREFIX}/Caskroom"
fi

# JAVA_TOOL_OPTIONS
if /usr/libexec/java_home 1> /dev/null 2>&1; then
    export JAVA_HOME
    JAVA_HOME=$(/usr/libexec/java_home)
fi
export _JAVA_OPTIONS="-Djava.awt.headless=true"
export GROOVY_HOME="$HOMEBREW_PREFIX/opt/groovy/libexec"
export GEM_HOME="$XDG_DATA_HOME/gem"

export PATH="$HOME/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$GEM_HOME/bin:$HOME/Library/Python/3.9/bin:$PATH"
export PATH="$PATH:$XDG_DATA_HOME/rvm/bin" # Add RVM to PATH for scripting

export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman:$MANPATH"
export MANPAGER="nvim +Man!"

export MAVEN_OPTS='-Xmx1500M'

export rvm_path="$XDG_DATA_HOME/rvm"
export GEM_SPEC_CACHE="$XDG_DATA_HOME/gem/specs"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

if command -v gpg-agent >/dev/null; then
    if [ -f  "${XDG_CACHE_HOME}/gpg/gpg-agent-info" ]; then
        . "${XDG_CACHE_HOME}/gpg/gpg-agent-info"
        export GPG_AGENT_INFO
    fi
    if ! gpg-agent 2>/dev/null; then
        mkdir -p "${XDG_CACHE_HOME}/gpg"
        eval "$(gpg-agent --daemon --no-allow-external-cache --write-env-file "${XDG_CACHE_HOME}/gpg/gpg-agent-info")"
        export GPG_AGENT_INFO
    fi
fi

# rvm doubles startup time, disable it unless it's necessary
# [ -s "$XDG_DATA_HOME/rvm/scripts/rvm" ] && . "$XDG_DATA_HOME/rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -f ~/.profile.local ] && . ~/.profile.local
