#!/bin/sh

echo "Setting up your Mac..."

# $DOTFILES is normally set by .zshrc, but on a fresh machine this script
# runs before .zshrc is in place
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Check for Oh My Zsh and install if we don't have it
# (omz is a zsh function, not a binary, so check for the directory)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # --unattended: don't switch shell mid-script, don't start a new zsh
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)" "" --unattended
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

# Symlink AI agent config (Claude Code, Codex, etc.)
# Run before installing the shared ai-tools repo, see ai/install.sh
bash $DOTFILES/ai/install.sh

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
# Note: the mas entries require being signed in to the App Store first
brew bundle --file $DOTFILES/Brewfile

# Create a Code directory
#mkdir $HOME/Code

# Set macOS preferences - we will run this last because this will reload the shell
. $DOTFILES/.macos
