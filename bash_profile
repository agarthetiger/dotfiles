# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Load bash aliases
if [ -r ~/.bash_alias ]; then
  . ~/.bash_alias
fi

# User specific environment and startup programs
if [ -e ~/.secrets -a -r ~/.secrets ]; then
  . ~/.secrets
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
		cat ~/.ssh/conf.d/* | \
			grep "^Host " | \
			awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

# Fix for __NSCFConstantString initialize may have been in progress in another thread when fork() was called.
# Read https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra-and-what-can-be-done-about-it/
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# WarpDir (v1.6.0, appended on 2017-12-28 11:23:00 +0000) BEGIN
[[ -f ~/.bash_wd ]] && source ~/.bash_wd
# WarpDir (v1.6.0, appended on 2017-12-28 11:23:00 +0000) END

# Turn on colours for ls by default
export CLICOLOR=true

# Customise the mac terminal prompt for git
GIT_PROMPT=/usr/local/etc/bash_completion.d/git-prompt.sh
if [ -f $GIT_PROMPT ]; then
	source $GIT_PROMPT
fi
# See https://mjswensen.com/blog/2014/08/07/git-status-prompt-options/
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
RED="\[\033[31m\]"
YELLOW="\[\033[33m\]"
GREEN="\[\033[32m\]"
PURPLE="\[\033[35m\]"
CYAN="\[\033[36m\]"
NO_COLOUR="\[\033[0m\]"
shopt -s promptvars
export PS1="${PURPLE}\u@\h${NO_COLOUR} ${YELLOW}\w${CYAN} \$(__git_ps1 "%s") ${NO_COLOUR}"$'\n\$ '

# MacPorts Installer addition on 2019-07-30_at_23:06:46: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
export PATH

HISTSIZE=9999
HISTFILESIZE=9999
HISTTIMEFORMAT='%F %T '

eval "$(register-python-argcomplete pipx)"

export PATH="$HOME/.poetry/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/garneran/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
