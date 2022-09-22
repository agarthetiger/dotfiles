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
bindkey "[C" forward-word
bindkey "[D" backward-word


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
if [ -r ~/.docker_aliases ]; then
. ~/.docker_aliases
fi
if [ -r ~/.git_aliases ]; then
. ~/.git_aliases
fi

###############################################################################
# p10k
###############################################################################
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###############################################################################
# Pipx
###############################################################################
autoload -U bashcompinit
bashcompinit

eval "$(register-python-argcomplete pipx)"

export PATH="$PATH:/Users/andrewgarner/.local/bin"

#################
# Other
##############

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrewgarner/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrewgarner/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/andrewgarner/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrewgarner/google-cloud-sdk/completion.zsh.inc'; fi
