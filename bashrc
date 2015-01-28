if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

cdl() {
    cd $1
    ls
}

cpstat() {
    rsync -vrltD --stats --human-readable "$1" "$2" | pv -lep -s $((2 + $(find "$1" | wc -l)))
}

[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
