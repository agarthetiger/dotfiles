# dotfiles

* "Learn from history or be doomed to repeat it" - George Santayana (probably)*

If you spend any time working with a command prompt it's worth learning about dotfiles. Little things like typing the beginning of a command and pressing the up arrow to search backwards through your command history for matching commands are the tip of the useful iceberg. dotfiles are as old as the universe, give or take a few billion years, and well worth a few hours to delve into. Your investment of time learning about what you can do will be well rewarded.

Learn more my dotfiles by having a browse here, or get started learning about other peoples [dotfiles on GitHub](https://dotfiles.github.io/)

## Overview

My current implementation uses `rcm` to [manage my dotfiles](https://thoughtbot.com/upcase/videos/manage-and-share-your-dotfiles-with-rcm) on any given host. `rcm` does not manage the synchronisation of these files between hosts, that part is managed using git with GitHub but it is not automatic. I have to use my usual workflow to commit and push changes in order to pull them down on other hosts.

## Usage

### Checkout on a new host

```sh
# Install rcm
brew install rcm

# Clone the repo
git clone https://github.com/agarthetiger/dotfiles.git ~/.dotfiles

# Bootstrap configuration
cd ~/.dotfiles
RCRC=~/.dotfiles/rcrc

# List what will be managed
lsrc

# Run rcm to set things up. User will be promoted for any files which would be overwritten.
rcup
```

### Making changes

As all the files are sym-linked, updating any file is as simple as editing the file(s) locally.

### Pushing changes

Note `gcap` is one of my local aliases to add (update) all git-managed files, use the following string as the commit message, commit and push the current branch.

```sh
cd ~/.dotfiles && gcap ""
```

### Pulling changes

```sh
cd ~/.dotfiles && git pull
```

## Challenges

* Often my username will differ between machines, so setting the full path to my home folder will not result in portable configutation. Check for differences and update scripts to use `$HOME` instead of the full explicit path, and hope everything plays nicely with this!
* Files like zshrc will contain configuration for multiple other tools. All of those also need to be managed, otherwise you may end up with a broken system. External dependencies need to be installed in the same way, such as warp dir, pipx, fzf, etc.
* Where I know will have configuration I don't want to sync, often from work laptops, this config needs to be sourced from a separate file(s) not managed with rcm. This can mean splitting configuration for a tool across two files, one to be sync'd and one to remain local to my work machine. This can increase complexity.
* If you're starting from scratch, you may have to invest time in merging configuration files from multiple machines, remove and re-install packages by the same installation method, or figure out how you manually configured something in the first place.

## References

* [RTM](https://thoughtbot.github.io/rcm/)
* [Thoughtbot video intro](https://thoughtbot.com/upcase/videos/manage-and-share-your-dotfiles-with-rcm)
