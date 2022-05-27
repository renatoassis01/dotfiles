#! /bin/bash
set -euo pipefail

# Debian likes
if [ -x "$(command -v apt)" ]; then
    sudo apt update && sudo apt install -y curl zsh stow kitty unzip wget xclip make postgresql-client shellcheck pspg miller pv
fi

# Arch likes
if [ -x "$(command -v pacman)" ]; then
   sudo pacman -S stow zsh kitty unzip wget terminator xclip make shellcheck pspg miller pv
fi

clear

# add micro
curl-s https://getmic.ro | bash
sudo mv micro /usr/bin

PLUGINS="$(cat ./config/micro/plugins.txt)"
for line in $PLUGINS
do
  micro -plugin install "$line"
done

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
git clone https://github.com/zdharma-continuum/history-search-multi-word "$HOME/.oh-my-zsh/custom/plugins/history-search-multi-word"
fi

# Install node version manager
if [[ ! -d "$HOME/.nvm" ]]; then
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
fi

clear

# Install Nerd Fonts
curl -s https://gist.githubusercontent.com/renatoassis01/327adfc5e80a7b3537c9918254cdf468/raw | bash

# ijq
if [[ ! -x "$(command -v ijq)" ]]; then
curl -s -o /tmp/x.tar.gz  https://git.sr.ht/~gpanders/ijq/refs/download/v0.3.6/ijq-0.3.6-linux-x86_64.tar.gz \
&& tar -xvzf /tmp/x.tar.gz -C /tmp && sudo cp /tmp/ijq-0.3.6/ijq /usr/local/bin 
fi

# Workspace
mkdir -p "$HOME/workspace"

echo -e "Install Dotfiles"

# Install Dotfiles
./install.sh

# Set zsh default shell user
chsh -s "$(command -v zsh)"

echo -e "You must start a new shell session"
sleep 2
exit 0
