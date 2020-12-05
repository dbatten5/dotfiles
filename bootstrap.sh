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

OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo 'Installing oh-my-zsh...'
  ruby -e "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Configuring ZSH"
echo "================================"
ZSH_CUSTOM=$OMZDIR/custom
for config in $(pwd)/zsh/**/*.zsh; do
  [ -e "$config" ] || continue
  echo "Adding $(basename -- $config)"
  ln -sv $config $ZSH_CUSTOM
done

echo "Setting up iTerm"
echo "================================"
echo "Creating zshrc symlink..."
ln -sv $(pwd)/zsh/zshrc $HOME/.zshrc
echo "Adding profiles..."
ln -sv $(pwd)/iterm/profiles.json $HOME/Library/Application\ Support/iTerm2/DynamicProfiles/

echo "Setting up remaining config files..."
[[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim
ln -sv $(pwd)/nvim $HOME/.config/nvim
ln -sv $(pwd)/vim/vintrc.yml $HOME/.vintrc.yml
ln -sv $(pwd)/git/gitconfig $HOME/.gitconfig
ln -sv $(pwd)/git/gitignore_global $HOME/.gitignore_global
[[ ! -d $HOME/.k8s ]] && mkdir -p $HOME/.k8s
ln -sv $(pwd)/k8s/templates $HOME/.k8s

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
defaults write com.apple.dock magnification -bool NO

echo "Set fast key repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

# map caps lock to control

# Change default shell
if [! $0 = "-zsh"]; then
  echo 'Changing default shell to zsh...'
  chsh -s /bin/zsh
else
  echo 'Already using zsh'
fi
