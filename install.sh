#!/usr/bin/env zsh

echo ">>>>>>Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null
echo ">>>>>>Installing homebrew packages..."
brew bundle --file=~/.dotfiles/brew/.Brewfile

