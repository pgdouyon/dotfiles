#!/bin/bash

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch=" git:(${branch})"
    fi
fi

printf '\033[36m%s\033[m@\033[32m%s\033[m:\033[33;1m%s\033[35m%s\033[m' \
    "$(whoami)" \
    "$(hostname -s)" \
    "$cwd" \
    "$git_branch"
