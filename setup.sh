#! /bin/bash
set -euo pipefail

# debian likes
if [ -x "$(command -v apt)" ]; then
   sudo apt update && sudo apt install -y zsh stow kitty unzip wget
fi

# arch likes
if [ -x "$(command -v pacman)" ]; then 
   sudo pacman  -Syu stow 
   sudo pacman  -Syu zsh
   sudo pacman  -Syu kitty
   sudo pacman  -Syu unzip
   sudo pacman  -Syu wget
fi

clear

echo -e "Setup oh-my-zsh"

### Added oh-my-zsh
if [[ ! -d $HOME/.oh-my-zsh ]]; then
 git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting  ]]; then
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]]; then
 git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi 

clear

# Install nerd fonts
curl -s https://gist.githubusercontent.com/renatoassis01/327adfc5e80a7b3537c9918254cdf468/raw | bash 


echo -e "Install Dotfiles"

# Install Dotfiles
./install.sh

#Set zsh default shell user 
chsh -s $(which zsh)


echo -e "You must start a new shell session"
sleep 2
exit 0







