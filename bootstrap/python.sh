#!/bin/bash

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    neovim
    pynvim
    virtualenv
)
sudo pip install "${PYTHON_PACKAGES[@]}"
