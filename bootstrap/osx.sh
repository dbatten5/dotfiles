#!/bin/bash

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable 'natural' scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Set Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock magnification -bool NO

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
