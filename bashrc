
cdl() {
    cd $1
    ls
}

cpstat() {
    rsync -vrltD --stats --human-readable "$1" "$2" | pv -lep -s $((2 + $(find "$1" | wc -l)))
}

eval "$(fasd --init auto)"
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases && _fasd_bash_hook_cmd_complete v vv j jj o
