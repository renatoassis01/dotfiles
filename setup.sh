#! /bin/bash
set -euo pipefail

# Debian likes
if [ -x "$(command -v apt)" ]; then
    sudo apt update && sudo apt install -y curl zsh stow kitty unzip wget xclip make postgresql-client shellcheck
fi

# Arch likes
if [ -x "$(command -v pacman)" ]; then
   sudo pacman -S stow zsh kitty unzip wget terminator xclip make shellcheck
fi

clear

echo -e "Setup oh-my-zsh"

# Added oh-my-zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
 git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"  ]]; then
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search" ]]; then
 git clone https://github.com/zsh-users/zsh-history-substring-search "$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search"
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/history-search-multi-word" ]]; then
git clone https://github.com/zdharma/history-search-multi-word "$HOME/.oh-my-zsh/custom/plugins/history-search-multi-word"
fi

# Install node version manager
if [[ ! -d "$HOME/.nvm" ]]; then
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
fi

clear

# Install Nerd Fonts
curl -s https://gist.githubusercontent.com/renatoassis01/327adfc5e80a7b3537c9918254cdf468/raw | bash


# Workspace
mkdir -p $HOME/workspace

echo -e "Install Dotfiles"

# Install Dotfiles
./install.sh

# Set zsh default shell user
chsh -s $(which zsh)

echo -e "You must start a new shell session"
sleep 2
exit 0
