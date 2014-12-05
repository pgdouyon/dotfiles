if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# color term
export CLICOLOR=1

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

export EDITOR=vim

export JAVA_HOME=$(/usr/libexec/java_home)

[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
