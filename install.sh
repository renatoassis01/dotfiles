#! /bin/bash
mkdir -p "$HOME/.zsh"
mkdir -p "$HOME/.config/starship"
mkdir -p "$HOME/.config/lazygit"
mkdir -p "$HOME/.config/nvim"

# clone plugin do zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

stow -v  --target="$HOME/.config" config
stow -v  --dotfiles --target="$HOME" home 


