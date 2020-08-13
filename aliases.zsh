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
alias hostfile="sudo nano /etc/hosts"

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# GIT
alias gs="git status"
alias gpull="git pull"
alias gpush="git push"
alias gd="git diff"
alias gl="git log --graph --pretty=format:\"%C(yellow)%h%Creset%C(cyan)%C(bold)%d%Creset %C(cyan)(%cr)%Creset %C(green)%ce%Creset %s\""
alias gc="git checkout"
alias gcb="git checkout -b"
alias gmerge="git pull --rebase origin develop"
alias nah="git reset --hard; git clean -df;"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# PHP
alias a="php artisan"
alias pa="php artisan"
alias art="php artisan"
alias phpspec="vendor/bin/phpspec run"
alias phpunit="vendor/bin/phpunit"
alias pu="vendor/bin/phpunit"
alias puf="phpunit --filter"
alias pus="pu --stop-on-failure"
alias c="composer"
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias cdu="composer dump"
alias cda="composer dump-autoload -o"
alias vi="rm ~/.config/valet/valet.sock && valet install"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Greps
alias gr="a route:list | grep"
alias ga="cat $DOTFILES/aliases.zsh | grep"

# Other
alias md5sum='md5 -r'

# Functions
phpv() {
    valet stop
    brew unlink php@7.0 php@7.1 php@7.2 php@7.3
    brew link --force --overwrite $1
    brew services start $1
    composer global update
	rm -f ~/.config/valet/valet.sock
    valet install
}

alias php70="phpv php@7.0"
alias php71="phpv php@7.1"
alias php72="phpv php@7.2"
alias php73="phpv php@7.3"
alias php74="phpv php"


