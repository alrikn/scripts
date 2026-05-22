#!/bin/bash
basepath=$1

PATH="$PATH:.:/home/user/.local/share/bob/nvim-bin:/home/user/.cargo/bin"

$basepath/local_files.sh

alias coding-style=$basepath/epitech_coding-style.sh
alias banana=$basepath/epitech_norminette.sh
alias header=$basepath/epitech_header.sh
alias fcreate=$basepath/epitech_file_create.sh
alias gidentity=$basepath/git_identity.sh
alias addLib=$basepath/start_lib_repo.sh
alias norminette="python3 -m norminette"

alias gtree='git log --graph --decorate --oneline --all'
alias vf='valgrind --leak-check=full --track-origins=yes --show-reachable=yes --show-leak-kinds=all -s' #valgrind full
alias vfl='valgrind --log-file="valgrind_log.log" --track-origins=yes --leak-check=full --show-leak-kinds=all --show-reachable=yes -s'
alias rcpns='rsync -av --progress --exclude=".*"' #recursive copy no secret files or directories
alias sl='/usr/games/sl; clear'
alias train='sl'
alias wunderbar='echo "wonderful"'
alias rick='curl ascii.live/rick'
alias korn='ksh'
alias kentucky='echo "fried chicken"'
alias kys='echo "keep yourself safe"'
