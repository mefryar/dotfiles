#!/usr/bin/env bash
# =========================================================================== #
# Description: Create symlinks from ~ to dotfiles in ~/dotfiles
# Author: Michael Fryar
# Hat Tip: https://github.com/michaeljsmalley/dotfiles

# Variables
## Dotfiles directory
dir=~/dotfiles
## Files to symlink in homedir
files="bash_profile bashrc gitconfig git-completion.bash gitignore
git-prompt.sh pensieve_mercury_credentials.txt"
# Create symlinks from the homedir to files in the ~/dotfiles directory
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
