#!/usr/bin/env bash
# =========================================================================== #
# Description: BASH configurations and aliases
# Author: Michael Fryar
# Note: Linux and Unix run .bash_profile for login shells (i.e. shells that
#       require you to type your user name and password). For non-login shells,
#       a different file, .bashrc, is run. This means that .bash_profile is run
#       only once when you login and .bashrc is run for every new interactive
#       shell.
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

# Enable vi-mode editing and set key bindings to default
set -o vi
# Insert string at the start of the line to indicate Vi mode (ins or cmd)
bind "set show-mode-in-prompt on"

# Enable bash completion support for Git
source ~/.git-completion.bash

# Customize PS1 (Prompt String 1) to show Git status
source ~/.git-prompt.sh
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds current branch name
# '\W' adds the name of the current directory
export PS1=" $cyan\u$yellow \W$green\$(__git_ps1) $ $reset"
# Show unstaged (*) and staged (+) changes next to the branch name
export GIT_PS1_SHOWDIRTYSTATE=1
# Show stashed ($) changes next to branch name
export GIT_PS1_SHOWSTASHSTATE=1

# Alias for Sublime Text 3
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Alias for sublime-text-settings repo
alias st3-settings="cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"

# Alias for visualizing git history (h/t Angela Ambroz)
alias glg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

# Allow navigating back multiple directory levels
alias ..='cd ../'                            # Go back 1 directory level
alias ..2='cd ../../'                        # Go back 2 directory levels
alias ..3='cd ../../../'                     # Go back 3 directory levels
alias ..4='cd ../../../../'                  # Go back 4 directory levels
alias ..5='cd ../../../../../'               # Go back 5 directory levels
alias ..6='cd ../../../../../../'            # Go back 6 directory levels

# If on Juntos laptop
if [ `whoami` = "michael" ]
then
  # Automatically initialize pyenv
  eval "$(pyenv init -)"
  # Add Pensieve and Mercury credentials from untracked file
  source ~/.pensieve_mercury_credentials.txt
# If on personal laptop
elif [ `whoami` = "mefryar" ]
then
  # Specify path to Anaconda
  export PATH="/Users/mefryar/anaconda3/bin:$PATH"
fi
