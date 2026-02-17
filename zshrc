# =========================================================================== #
# Description: ZSH configurations and aliases
# Author: Michael Fryar

# If on Nubank laptop...
if [ `whoami` = "michael.fryar" ]
then
  # Load Nubank zshrc
  source ~/.zshrc.nubank
fi

# Vi mode
bindkey -v

# Add zsh-syntax-highlighting installed via Homebrew
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize fuzzy finding via fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GPG Configuration - Fix for "Inappropriate ioctl for device" error
export GPG_TTY=$(tty)

# =========================================================================== #
# Git Aliases (formerly from oh-my-zsh git plugin)
# =========================================================================== #

# Helpers used by some aliases
git_current_branch() { git rev-parse --abbrev-ref HEAD }
git_main_branch() {
  local ref
  for ref in refs/heads/main refs/heads/master refs/remotes/origin/main refs/remotes/origin/master; do
    if git show-ref -q --verify "$ref"; then
      echo "${ref##*/}"
      return 0
    fi
  done
  echo main
}

# Add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

# Branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'

# Commit
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'

# Diff
alias gd='git diff'
alias gds='git diff --staged'

# Pull / Push
alias gl='git pull'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

# Log
alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'

# Rebase
alias grbi='git rebase --interactive'

# Restore
alias grs='git restore'
alias grst='git restore --staged'

# Stash
alias gsta='git stash push'
alias gstp='git stash pop'

# Status
alias gst='git status'
alias gss='git status --short'

# Switch
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(git_main_branch)'

# =========================================================================== #
# Git Worktree + Claude Code
# =========================================================================== #

# Create a worktree for the current branch and launch Claude in it
claude-worktree() {
  local repo_root=$(git rev-parse --show-toplevel)
  local repo_name=$(basename "$repo_root")
  local branch=$(git branch --show-current)
  local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  default_branch="${default_branch:-main}"
  local wt_dir="$NU_HOME/worktrees/${repo_name}/${branch}"

  if [ "$branch" = "$default_branch" ]; then
    echo "You're on $branch. Switch to a feature branch first."
    return 1
  fi

  if [ ! -d "$wt_dir" ]; then
    mkdir -p "$(dirname "$wt_dir")"
    git checkout "$default_branch"
    git worktree add "$wt_dir" "$branch"
  fi

  cd "$wt_dir" && claude
}
alias cw=claude-worktree

# Remove all worktrees for the current repo (interactive)
remove-worktrees() {
  local repo_root=$(git rev-parse --show-toplevel)
  local repo_name=$(basename "$repo_root")
  local wt_base="$NU_HOME/worktrees/${repo_name}"

  if [ ! -d "$wt_base" ]; then
    echo "No worktree directory found at $wt_base"
    return 0
  fi

  for wt in "$wt_base"/*/; do
    [ -d "$wt" ] || continue
    local wt_name=$(basename "$wt")

    if git -C "$wt" diff --quiet 2>/dev/null && git -C "$wt" diff --cached --quiet 2>/dev/null; then
      echo "Removing worktree: $wt_name"
      git worktree remove "$wt"
    else
      echo "Worktree '$wt_name' has uncommitted changes."
      read -q "REPLY?  Force remove? [y/N] "
      echo
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        git worktree remove "$wt" --force
      else
        echo "  Skipped."
      fi
    fi
  done

  rmdir "$wt_base" 2>/dev/null
  echo "Done."
}

# Initialize Starship prompt
eval "$(starship init zsh)"

# Initialize zoxide: A smarter cd command
eval "$(zoxide init zsh)"
