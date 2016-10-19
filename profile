#!/bin/sh
export EDITOR=vim
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

export JAVA_HOME=`/usr/libexec/java_home`
# JAVA_TOOL_OPTIONS
export _JAVA_OPTIONS="-Djava.awt.headless=true"
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export MANPAGER="nvim -c 'set ft=man' - ; echo"

export MAVEN_OPTS='-Xmx1000M -XX:MaxPermSize=800M'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export rvm_path="$XDG_DATA_HOME/rvm"
export GEM_SPEC_CACHE="$XDG_DATA_HOME/gem/specs"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo:
export _FASD_DATA="$XDG_DATA_HOME/fasd"

export PATH="$PATH:$XDG_DATA_HOME/rvm/bin" # Add RVM to PATH for scripting

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

[ -s "$XDG_DATA_HOME/rvm/scripts/rvm" ] && . "$XDG_DATA_HOME/rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -f ~/.profile.local ] && . ~/.profile.local
