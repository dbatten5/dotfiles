#!/bin/bash

# Inspiration
# - https://gist.github.com/codeinthehole/26b37efa67041e1307db#file-osx_bootstrap-sh
# - https://gist.github.com/jexchan/5754956

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if [[ ! $(which brew) ]]; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

OMZDIR="$HOME/.oh-my-zsh"
if [[ ! -d "$OMZDIR" ]]; then
    echo 'Installing oh-my-zsh...'
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Configuring ZSH"
echo "================================"
ZSH_CUSTOM="${OMZDIR}/custom"
for config in "$(pwd)"/zsh/**/*.zsh; do
    [[ -e "$config" ]] || continue
    echo "Adding $(basename -- $config)"
    ln -sv "$config" "$ZSH_CUSTOM"
done
ln -sv "$(pwd)/zsh/zshrc" "${HOME}/.zshrc"

