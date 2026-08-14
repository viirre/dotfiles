#!/bin/bash

# Read JSON input once
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Extract context percentage
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Model and reasoning effort
model=$(echo "$input" | jq -r '.model.display_name // "?"')
effort=$(echo "$input" | jq -r '.effort.level // "?"')
model_seg=$(printf '\033[01;35m%s\033[00m \033[02m(%s)\033[00m' "$model" "$effort")

# Git information
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  # Get repo name (just the directory name)
  repo_name=$(basename "$cwd")

  # Color the context percentage based on usage
  if [ "$ctx_pct" -ge 60 ]; then
    ctx_color='\033[01;31m' # red
  elif [ "$ctx_pct" -ge 40 ]; then
    ctx_color='\033[01;33m' # yellow
  else
    ctx_color='\033[01;32m' # green
  fi

  printf '\033[01;36m%s\033[00m | ctx: %b%s%%\033[00m | %b' \
    "$repo_name" "$ctx_color" "$ctx_pct" "$model_seg"
else
  printf '\033[01;36m%s\033[00m | ctx: %s%% | %b' "$cwd" "$ctx_pct" "$model_seg"
fi
