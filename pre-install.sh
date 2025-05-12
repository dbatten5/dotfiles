#!/bin/bash

# Check for Homebrew
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed successfully."
else
  echo "Homebrew is already installed."
fi

# Ensure brew is in PATH
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

# Check for Dotbot
if ! brew list dotbot &>/dev/null; then
  echo "Dotbot not found. Installing Dotbot via Homebrew..."
  brew install dotbot
  echo "Dotbot installed successfully."
else
  echo "Dotbot is already installed."
fi
