export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

set -o vi

shopt -s expand_aliases

cdl() {
    cd $1
    ls
}

cpstat() {
    rsync -vrltD --stats --human-readable "$1" "$2" | pv -lep -s $((2 + $(find "$1" | wc -l)))
}

fgs() {
    git show $(git log --oneline | fzf | awk '{print $1}')
}

fgfiles() {
    git status --porcelain | sed -e 's/^ *[^ ]* *//' | fzf
}

fgd() {
    git diff `git status --porcelain | sed -e 's/^ *[^ ]* *//' | fzf`
}

fgdc() {
    git diff --cached `git status --porcelain | sed -e 's/^ *[^ ]* *//' | fzf`
}

if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    . $(brew --prefix)/etc/bash_completion
fi

eval "$(fasd --init auto)"
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases && _fasd_bash_hook_cmd_complete v vv vm j jj o
