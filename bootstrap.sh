#!/bin/bash

# Inspiration
# - https://gist.github.com/codeinthehole/26b37efa67041e1307db#file-osx_bootstrap-sh
# - https://gist.github.com/jexchan/5754956

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install Bash 4
brew install bash

PACKAGES=(
    automake
    fzf
    gettext
    git
    markdown
    neovim
    npm
    pkg-config
    python
    python3
    pypy
    the_silver_searcher
    tree
    universal-ctags
    vim
    wget
    zsh
    zsh-syntax-higlighting
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    flux
    google-chrome
    google-drive
    gpgtools
    iterm2
    slack
    spectacle
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing oh-my-zsh..."
ruby -e "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setting up iTerm"
echo "================================"
echo "Creating zshrc symlink..."
ln -sv $(pwd)/zsh/zshrc ~/.zshrc
echo "Adding profiles..."
ln -sv $(pwd)/iterm/profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/

echo "Setting up remaining config files..."
[[ ! -d ~/.config/nvim ]] && mkdir -p ~/.config/nvim
ln -sv $(pwd)/nvim ~/.config/nvim

# PYTHON PACKAGES
echo "Installing Python packages..."
PYTHON_PACKAGES=(
    neovim
    pynvim
    virtualenv
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Configuring OSX"
echo "================================"
echo "Enabling tap-to-click..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Disabling 'natural' scroll..."
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Setting Dock to auto-hide and removing the auto-hiding delay..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Set fast key repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

# map caps lock to control
