# =========================================================================== #
# Description: ZSH configurations and aliases
# Author: Michael Fryar

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load plugins
plugins=(
  git
  heroku
  rails
  sublime
)
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Automatically initialize rbenv
eval "$(rbenv init -)"

# Automatically initialize pyenv and pyenv-virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Enable prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# If on Juntos laptop
if [ `whoami` = "michael" ]
then
  # Add Pensieve and Mercury credentials from untracked file
  source ~/.pensieve_mercury_credentials.txt
fi
