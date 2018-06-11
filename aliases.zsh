# CLI Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias weather="curl -4 http://wttr.in/stockholm"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"
alias ll="ls -lahF"

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# GIT
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --decorate --color"
alias gc="git checkout -b"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# PHP
alias a="php artisan"
alias pa="php artisan"
alias art="php artisan"
alias phpspec="vendor/bin/phpspec run"
alias phpunit="vendor/bin/phpunit"
alias c="composer"
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias cdu="composer dump"
alias cda="composer dump-autoload -o"
alias hostfile="sudo nano /etc/hosts"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Greps
alias gr="a route:list | grep"
alias ga="cat ~/.dotfiles/aliases.zsh | grep"
