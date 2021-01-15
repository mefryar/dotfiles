#!/usr/bin/env bash
# =========================================================================== #
# Description: Create symlinks from ~ to dotfiles in ~/dotfiles
# Author: Michael Fryar
# Hat Tip: https://github.com/michaeljsmalley/dotfiles

# Variables
## Dotfiles directory
dir=~/dotfiles
## Files to symlink in homedir
files="gitconfig inputrc vimrc zshrc"
# Create symlinks from the homedir to files in the ~/dotfiles directory
for file in $files; do
	# Check if file already exists
	if [ ! -f ~/.$file ]; then
		echo "Creating symlink to ~/.$file"
		ln -s $dir/$file ~/.$file
	else
		echo "~/.$file already exists"
	fi
done

# Custom symlink for aliases
echo "Creating symlink to .oh-my-zsh/custom/aliases.zsh in home directory."
ln -s ~/dotfiles/aliases ~/.oh-my-zsh/custom/aliases.zsh
