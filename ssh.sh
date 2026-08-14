#!/bin/sh

# Keys are copied from 1password..
#echo "Generating a new SSH key for GitHub..."

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
# ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_rsa

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

# printf, not echo: /bin/sh echo writes the \n escapes literally, producing an invalid ssh config
mkdir -p ~/.ssh
printf '%s\n' \
  'Host *' \
  '  AddKeysToAgent yes' \
  '  UseKeychain yes' \
  '  IdentityFile ~/.ssh/id_rsa' \
  > ~/.ssh/config

# --apple-use-keychain replaced the deprecated -K flag (macOS 12+)
ssh-add --apple-use-keychain ~/.ssh/id_rsa

# Adding your SSH key to your GitHub account
# https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
echo "run 'pbcopy < ~/.ssh/id_rsa.pub' and paste that into GitHub"
