phpv() {
    valet stop
    brew unlink php@7.0 php@7.1 php@7.2
    brew link --force --overwrite $1
    brew services start $1
    composer global update
    rm /Users/$USER/.config/valet/valet.sock
    valet install
}
