# alias vim='mvim -v'
alias tmux='tmux -2'
alias ls='ls -hFG'
alias up='cd ..'

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
alias gss='git stash save'
alias gsp='git stash pop'
alias gsl='git stash list'

if [ "`uname -s`" = Darwin ]; then
    alias locate='mdfind -name'
fi

# Fasd aliases
alias v='f -e nvim'
alias vv='f -i -e nvim'
alias vm='f -t -e nvim -b viminfo'
alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias o='a -e open'
