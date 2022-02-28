<p align="center"><img src="art/banner-2x.png"></p>

## Introduction

This repository serves as my way to help me setup and maintain my Mac. It takes the effort out of installing everything manually. Everything needed to install my preferred setup of macOS is detailed in this readme. Feel free to explore, learn and copy parts for your own dotfiles. Enjoy!

📖 - [Read the blog post](https://driesvints.com/blog/getting-started-with-dotfiles)  
📺 - [Watch the screencast on Laracasts](https://laracasts.com/series/guest-spotlight/episodes/1)  
💡 - [Learn how to build your own dotfiles](https://github.com/driesvints/dotfiles#your-own-dotfiles)

## A Fresh macOS Setup

These instructions are for when you've already set up your dotfiles. If you want to get started with your own dotfiles you can [find instructions below](#your-own-dotfiles).

### Before you re-install

First, go through the checklist below to make sure you didn't forget anything before you wipe your hard drive.

- Did you commit and push any changes/branches to your git repositories?
- Did you remember to save all important documents from non-iCloud directories?
- Did you save all of your work from apps which aren't synced through iCloud?
- Did you remember to export important data from your local database?
- Did you update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`?

### Installing macOS cleanly

After going through our checklist above and making sure you backed everything up, we're going to cleanly install macOS with the latest release. Follow [this article](https://www.imore.com/how-do-clean-install-macos) to cleanly install the latest macOS version.

### Setting up your Mac

If you did all of the above you may now follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store
2. Install 1password from the web and login with the help of another device
3. Copy your SSH keys from 1password to `~/.ssh`
4. Chmod your private key: `chmod 600 ~/.ssh/id_rsa`
5. Download the dotfiles:
   ```zsh
   curl https://raw.githubusercontent.com/viirre/dotfiles/HEAD/ssh.sh | sh -s "<your-email-address>"
   ```

6. Clone this repo to `~/.dotfiles` with:

    ```zsh
    git clone git@github.com:viirre/dotfiles.git ~/.dotfiles
    ```

7. Run the installation with:

    ```zsh
    ~/.dotfiles/fresh.sh
    ```
8. Restart your computer to finalize the process

Your Mac is now ready to use!

