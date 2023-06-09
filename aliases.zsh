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
alias commit="git add . && git commit -m"
alias wip="commit wip"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# PHP
#alias a="php artisan" # Use function below instead
alias pa="php artisan"
alias art="php artisan"
alias ashop="php ashop"
alias phpspec="vendor/bin/phpspec run"
alias phpunit="vendor/bin/phpunit"
alias pu="vendor/bin/phpunit"
alias puf="phpunit --filter"
alias pus="pu --stop-on-failure"
alias c="/opt/homebrew/bin/composer"
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias cdu="composer dump"
alias cda="composer dump-autoload -o"
alias vi="rm ~/.config/valet/valet.sock && valet install"
alias amfs="a migrate:fresh --seed"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Greps
alias gr="a route:list | grep"
alias ga="cat $DOTFILES/aliases.zsh | grep"
alias rgs="rg -F --"

# Other
alias md5sum='md5 -r'
alias ownit="ssh -4t deploy@login01.ownit.se ssh"
alias cat="bat"

# Git clone repo
function gitclone () {
   git clone git@github.com:adaptivemedia/$1
}

# Git rebase interactive
function rebase () {
  git rebase -i HEAD~$1
}

# Open database application from project
function opendb () {
   [ ! -f .env ] && { echo "No .env file found."; exit 1; }

   DB_CONNECTION="mysql"
   DB_HOST="127.0.0.1"
   DB_PORT="3306"
   DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

   DB_URL="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

   echo "Opening ${DB_URL}"
   open $DB_URL
}

# Quickly ssh into a Forge server
forge () {
    ssh forge@$1
}

# Ashop and artisan helper
a () {
   if [ -f "ashop" ]
   then
      php ashop "$@"
   else
      php artisan "$@"
   fi
}
