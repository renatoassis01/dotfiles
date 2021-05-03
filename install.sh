#! /bin/bash
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/lazygit

stow -v  --target=$HOME/.config config
stow -v  --dotfiles --target=$HOME home 