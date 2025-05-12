#!/bin/bash

# Install Python packages
PYTHON_PACKAGES=(
    virtualenv
)
sudo pip install "${PYTHON_PACKAGES[@]}"
