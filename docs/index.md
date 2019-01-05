# dotfiles

*"Learn from history or be doomed to repeat it" - George Santayana (probably)*

If you spend any time working with a command prompt it's worth learning about dotfiles. Little things like typing the beginning of a command and pressing the up arrow to search backwards through your command history for matching commands are the tip of the useful iceberg. dotfiles are as old as the universe, give or take a few billion years, and well worth a few hours to delve into. Your investment of time learning about what you can do will be well rewarded.

Learn more my dotfiles by having a browse here, or get started learning about other peoples dotfiles at https://dotfiles.github.io/

## Features
Features enabled by the dotFiles include

* Command history search from partially typed command, using the up arrow
* Save command history, and write history to file immediately, so history is available across login sessions and not lost if a session is closed unexpectedly
* Alias git commands for less typing. Yes, I know I could create aliases in git config, but these still require typing "git " and I prefer to use shorter shortcuts like "gs" to execute "git status -sb".
* Alias 'config' commands which are aliases for git commands specific to committing and pushing updates to versioned dotfiles
* Command line prompt colours and git branch display as per GitBash

## Using this repo
### Checkout on a new VM
"Standing on the shoulders of giants", or at least other people's work. The steps below are my personal take on what I read on https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
    
```bash
echo ".cfg" >> ~/.gitignore
git clone --bare git@github.com:agarthetiger/dotfiles.git ~/.cfg
# This should be in the .bashrc in version control, adding into the shell scope temporarily to make checkout easier later.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
# This will most likely list files which already exist on the local machine. 
# Remove the local files only after checking that the files listed don't contain anything which files from GitHub don't. 
# Without moving/removing these the checkout will fail. 
rm .bashrc
rm .bash_profile
# Once the local cleanup/backup is done, run the checkout again
config checkout
```

This could all be added to a script which could be downloaded from t'internet and piped directly into bash, but I'm not going to encourage or propagate that kind of behaviour. Seriously, [are you looking to get pwned](https://www.idontplaydarts.com/2016/04/detecting-curl-pipe-bash-server-side/)?

### Updating local from remote and committing local changes
The `config` command now aliases the git command, specifically for the dotfiles .cfg repo. I use aliases `gs`, `ga`, `gc` and `gp` for Git to check status, add, commit and push, so I've created similar aliases for `config` as `cs`, `ca`, and `cc`. `ca` differs from `ga` as I often want to add everything that has changed, but in this case also want to exclude untracked files, which is everything else in the home directory.