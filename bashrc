#!/usr/bin/env bash
# =========================================================================== #
# Description: BASH configurations and aliases
# Author: Michael Fryar
# Note: Linux and Unix run .bashrc for non-login shells. For login shells,
#       (i.e. shells that require you to type your user name and password), a
#       different file, .bash_profile, is run. This means that .bash_profile is
#       run only once when you login and .bashrc is run for every new
#       interactive shell.
#       macOS, in contrast, runs a login shell by default for each new
#       terminal window. This means that it is not necessary to have a .bashrc
#       in addition to your .bash_profile if working exclusively in macOS.

# Define colors
red="\[033[0;31m\]"
green="\[\033[0;32m\]"
yellow="\[\033[0;33m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
cyan="\[\033[0;36m\]"
white="\[\033[0;37m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$cyan\u$green\$(__git_ps1)$yellow \W $ $reset"

# Enable tab completion
source ~/.git-completion.bash

# Aliases that differ by operating system
if [ "$(uname)" == "Darwin" ]; then # macOS
    # Allow opening of Sublime Text from terminal by just typing "st3"
	alias st3="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then # Windows
	# Allow opening of Sublime Text from Git Bash by just typing "st3"
	alias st3="C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"

	# Allow opening of Python interpreter from Git Bash by just typing "python"
	alias python="winpty python.exe"

fi

# Alias for epodx data dashboard repo
alias dashboards="cd ~/EPoD/epodx-dashboards"

# Alias for epodx repo
alias epodx="cd ~/EPoD/epodx"

# Alias for sublime-text-settings repo
alias st3-settings="cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"

# Alias for visualizing git history (h/t Angela Ambroz)
alias glg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

# Allow navigating back multiple directory levels
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

# automatically initialize pyenv
export PATH="/Users/username/.pyenv:$PATH"
eval "$(pyenv init -)"

