# alias vim='mvim -v'
alias tmux='tmux -2'
alias ls='ls -hFG'
alias up='cd ..'

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
