# Victors Dotfiles 

## Oh my zsh with Dracula theme

### Before you re-install

First, go through the checklist below to make sure you didn't forget anything before you wipe your hard drive.

- Did you commit and push any changes/branches to your git repositories?
- Did you remember to save all important documents from non-iCloud directories?
- Did you save all of your work from apps which aren't synced through iCloud?
- Did you remember to export important data from your local database?
- Did you update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`?

### Setting up your Mac

If you did all of the above you may now follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. Agree to the Xcode license by running `sudo xcodebuild -license accept`
5. Copy your public and private SSH keys to `~/.ssh` and make sure they're set to `600`
6. Clone this repo to `~/dotfiles`: `git clone git@github.com:viirre/dotfiles ~/dotfiles`
7. Append `/usr/local/bin/zsh` to the end of your `/etc/shells` file
8. Run `./install.sh` to start the installation
10. Restart your computer
11. Login to dropbox and sync (smart sync)
12. Restore preferences by running `mackup restore`
13. Restart your computer

Your Mac is now ready to use!

### Notes

> You can use a different location than `~/dotfiles` if you want. Just make sure you also update the reference in the [`.zshrc`](./.zshrc) file.

> If your icons for apps are missing, run:
`sudo find /private/var/folders/ -name com.apple.iconservices -exec rm -rf {} \;
sudo rm -rf /Library/Caches/com.apple.iconservices.store
killall Dock`

> If 1password cannot autofill passwords in Chrome, reboot computer and try again.
If that doesn't work, install 1password via their website.