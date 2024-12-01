#!/bin/bash

# apt
alias aptate='apt update && apt list --upgradable'
alias aptgrade='apt update && apt upgrade -y && apt autoremove -y'

# df
alias lsfs='df -hlT -x overlay -x tmpfs'

# docker
alias container-exec='docker container exec -it'
alias compose-name="cat docker-compose.yml | grep -E '^name[^\r\n]+'"
alias docker-debug='docker run --rm --network exposed -it arunvelsriram/utils /bin/bash'

# du
alias dirsizes='du -hd 1'
alias largedirs='du -sch -t ${DIR_SIZE_LARGE:-50M} *'

# jq
alias jq-less='jq -C | less -R'

# ls
alias lc='ls -lAh'

# lspci
alias lspcitree='lspci -t -vv -k -PP -nn'

# netstat
alias lsconn='netstat -Wnepl'
alias lsconn4='lsconn -4'
alias lsconn6='lsconn -6'
alias lssock='lsconn -x'
alias lstcp='lsconn -t'
alias lstcp4='lstcp -4'
alias lstcp6='lstcp -6'
alias lsudp='lsconn -u'
alias lsudp4='lsudp -4'
alias lsudp6='lsudp -6'

# systemctl
alias sysrestart='systemctl restart'
alias sysstart='systemctl start'
alias sysstat='systemctl status'
alias sysstop='systemctl stop'

# tmux
alias tmatt='tmux attach -d'
