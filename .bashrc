# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Increase command history
HISTSIZE=1000000
HISTTIMEFORMAT="%d/%m/%y %T "
HISTFILESIZE=1000000000


# Enable multiple simultaneous terminal sessions to all save their command history 
shopt -s histappend

# Hack to immediately append commands to the command history, not just when the session ends
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Disable CTRL-s from freezing the terminal session
[[ $- == *i* ]] && stty -ixon

# git aliases
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

# Get path to installed git version, differs on ODD and GitBash
git_path=$(which git)

# Alias for config command to manage dotfiles and Git
alias config="$git_path --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias cs='config status'
alias ca='config add'
alias cc='config commit -m'
alias cca='config commit -am'
alias cpush='config push'

# Display Git branch and status on the command line prompt
# See https://fedoraproject.org/wiki/Git_quick_reference for commands and
# https://gist.github.com/githubteacher/e75edf29d76571f8cc6c for colours.
if [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]
then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
RED="\[\033[31m\]"
YELLOW="\[\033[33m\]"
GREEN="\[\033[32m\]"
PURPLE="\[\033[35m\]"
CYAN="\[\033[36m\]"
NO_COLOUR="\[\033[0m\]"
shopt -s promptvars
export PS1="${PURPLE}\u@\h${NO_COLOUR} ${YELLOW}\W${CYAN} \$(__git_ps1 "%s") ${NO_COLOUR}"$'\n\$ '

# Allow sourcing of additional options for specific hosts. 
# I use this for loading Windows/GitBash specifics on my development laptop.
if [ -e ~/.bashrc-$(hostname) ]
then
	. ~/.bashrc-$(hostname)
fi
