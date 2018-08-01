# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

alias gfp="git fetch --all --tags --prune && git pull"
alias gs="git status -sb"
alias ga="git add"
alias gau="git add -u"
alias gc="git commit -m"
alias gp="git push"

gcap() {
	ga .
	gc "$1"
	gp
}

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# Alias section for managing dotfiles from a git repository
alias config='/usr/bin/git --git-dir=/home/ec2-user/.cfg/ --work-tree=/home/ec2-user'
alias cs='config status'
alias ca='config add'
alias cc='config commit -m'
alias cca='config commit -am'
alias cpush='config push'

