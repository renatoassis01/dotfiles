#! /bin/bash
set -euo pipefail

# Debian likes
if [ -x "$(command -v apt)" ]; then
    sudo apt update && sudo apt install -y curl zsh stow kitty unzip wget xclip make postgresql-client shellcheck pspg miller pv neovim
fi

# Arch likes
if [ -x "$(command -v pacman)" ]; then
   sudo pacman -S stow zsh kitty unzip wget terminator xclip make shellcheck pspg miller pv neovim
fi

clear

## add zoxide
curl -sS https://webinstall.dev/zoxide | bash

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

# k8s tools kubectl
if [[ ! -x "$(command -v kubectl)" ]]; then
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

fi

# k8s tools krew
if [[ -x "$(command -v kubectl)" ]]; then
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
fi

# k8s tools helm
if [[ -x "$(command -v kubectl)" ]]; then
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
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
