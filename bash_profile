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

# Read .bashrc at startup
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# added by Anaconda3 5.0.1 installer
export PATH="/Users/mifryar/anaconda3/bin:$PATH"
. /Users/mifryar/anaconda3/etc/profile.d/conda.sh
conda activate
