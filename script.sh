echo "Configuring ZSH"
echo "================================"
ZSH_CUSTOM="${OMZDIR}/custom"
for config in "$(pwd)"/zsh/**/*.zsh; do
    [[ -e "$config" ]] || continue
    echo "Adding $(basename -- $config)"
    ln -sv "$config" "$ZSH_CUSTOM"
done
