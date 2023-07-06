# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###############################################################################
# General settings
###############################################################################

# Reverse search with up and down arrow keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey '[C' forward-word
bindkey '[D' backward-word
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

export TERM="xterm-256color"
export EDITOR="vim"

COMPLETION_WAITING_DOTS="true"

# Tab completion of SSH hostnames, including files in ~/.ssh/conf.d
# Note ~/.ssh/config needs the directive Include ~/.ssh/conf.d/* for this to work
# See https://www.codyhiar.com/blog/zsh-autocomplete-with-ssh-config-file/
# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Don't autocomplete from ip addresses in known_hosts
zstyle ':completion:*:ssh:*' hosts off

# ZSH history
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000 # Max size for storing history
setopt sharehistory # Immediately share history between terminals
setopt extendedhistory # Add timestamps

# Initialise completions
autoload -Uz compinit && compinit -i

# Fix for issue https://stackoverflow.com/questions/58272830/python-crashing-on-macos-10-15-beta-19a582a-with-usr-lib-libcrypto-dylib
export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH
# Fix for issue https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra-and-what-can-be-done-about-it/
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

if [ -r ~/.secrets ]; then
. ~/.secrets
fi
if [ -r ~/.zsh_aliases ]; then
. ~/.zsh_aliases
fi
if [ -r ~/.zsh_functions ]; then
  . ~/.zsh_functions
fi
if [ -r ~/.docker_aliases ]; then
. ~/.docker_aliases
fi
if [ -r ~/.git_aliases ]; then
. ~/.git_aliases
fi

# A separate file that gets sourced; convenient for putting things you may not want to upstream
() { local FILE="$ZDOTDIR/.zsh_local" && test -f $FILE && . $FILE }

###############################################################################
# p10k
###############################################################################
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###############################################################################
# Antigen
###############################################################################
source $(brew --prefix)/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle mfaerevaag/wd
antigen bundle command-not-found
antigen apply

###########################################################
# direnv - See https://direnv.net/
###########################################################
eval "$(direnv hook zsh)"

###########################################################
# kubeswitch
###########################################################
INSTALLATION_PATH=$(brew --prefix switch) && source $INSTALLATION_PATH/switch.sh

###############################################################################
# Pipx
###############################################################################
# These next two lines are to support using "complete" with zsh. pipx arg complete needs this.
# See https://github.com/eddiezane/lunchy/issues/57
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
eval "$(register-python-argcomplete pipx)"
export PATH="$PATH:$HOME/.local/bin"

###########################################################
# poetry
###########################################################
# Must come before compinit
# PATH="$PATH:$HOME/.poetry/bin"
fpath+=~/.zfunc

###############################################################################
# Pyenv
###############################################################################
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#################
# Other
##############
###############################################################################
# fzf
###############################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Enable Alt + c keybinding on MacOS, suggestion from https://github.com/junegunn/fzf/issues/164
bindkey "ç" fzf-cd-widget

# hint
#eval "$(_HINT_COMPLETE=zsh_source hint)"

# 1Password cli (op)
eval "$(op completion zsh)"; compdef _op op

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/andrewgarner/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrewgarner/google-cloud-sdk/completion.zsh.inc'; fi
