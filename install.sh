#!/bin/sh
export DOTFILES=$HOME/dotfiles

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Dracula theme
curl https://raw.githubusercontent.com/dracula/zsh/22058079469b74af07f1f4984df505f9b5156c1f/dracula.zsh-theme --output ~/.oh-my-zsh/themes/dracula.zsh-theme

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install PHP extensions with PECL
pecl install xdebug
pecl install redis
pecl install imagick

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Install global NPM packages
#npm install --global yarn

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Set git to use ssh (not http) by default
git config --global url.ssh://git@github.com/.insteadOf https://github.com/

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos

# Done!
echo "Done! Note that some of these changes require a logout/restart to take effect."
