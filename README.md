![dotfiles-logo](./assets/logo.png)

###

---

### Setup initial

```sh
./setup.sh
```

### Configs

- zsh
- oh-my-zsh
- powerlevel10k
- zsh plugins
- node version manager
- kitty
- terminator
- stow

## Without setup initial

### Install stow

https://www.gnu.org/software/stow/

### Install dotfiles

```
./install.sh
```

### Configs

- zinit
- tmux
- lazygit
- fd
- exa
- bat
- neovim
- glow
- dive
- dust
- hyperfine
- fzf

### Uninstall dotfiles

```
./uninstall.sh
```

### Config git user

```sh
git config --global --add --bool push.autoSetupRemote true
git config -f ~/.gitlocal user.email "email@yoursite.com"
```

```sh
git config -f ~/.gitlocal user.name "Name Lastname"
```
