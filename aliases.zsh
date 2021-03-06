
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
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# GIT
alias gs="git status"
alias pull="git pull"
alias push="git push"
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
alias ashop="php ashop"
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
alias brew2="arch -x86_64 brew"

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

# Open database application from project
function opendb () {
   [ ! -f .env ] && { echo "No .env file found."; exit 1; }

   DB_CONNECTION=$(grep DB_CONNECTION .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_HOST=$(grep DB_HOST .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PORT=$(grep DB_PORT .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

   DB_URL="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

   echo "Opening ${DB_URL}"
   open -a "sequel ace" $DB_URL
}
