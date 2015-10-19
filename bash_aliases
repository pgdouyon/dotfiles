alias tmux='tmux -2'
alias ls='ls -hFG --color=auto'
alias ll='ls -hlFG --color=auto'
alias up='cd ..'
alias v='nvim +NifflerMRU'
alias gtypist='gtypist -b -e0 -w -S'
alias jconsole='_JAVA_OPTIONS="" jconsole'

# git aliases
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gae='git add -e'
alias gb='git branch --color'
alias gci='git commit'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff --color'
alias gdc='git diff --cached --color'
alias ggo='git log --graph --decorate --oneline --color'
alias gm='git merge'
alias gmff='git merge --ff-only'
alias gmnf='git merge --no-ff'
alias gpo='git push origin master'
alias gst='git status'
alias gsh='git show HEAD'
alias gss='git stash save'
alias gsp='git stash pop'
alias gsl='git stash list'

if [[ $(uname -s) = Darwin ]]; then
    alias locate='mdfind -name'
fi

# Fasd aliases
alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias o='a -e open'

[ -f ~/.bash_aliases.local ] && source ~/.bash_aliases.local
