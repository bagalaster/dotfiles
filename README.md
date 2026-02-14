# dotfiles

This repo contains my dotfiles and configurations for my local workstation tools:

* neovim
* zsh (I use zinit)
* starship
* tmux

Additionally, it contains my personal git configuration.

## Quickstart instructions

### 1. Install just

On macOS, use brew. On Linux, use the standard package manager

```bash
brew install just
```

### 2. Run the installation recipe

Using just, from the root of this repo, run the `configure` recipe

```bash
just configure
```

## Syncing individual folders

To sync an individual folder from this repo to the workstation, run the `stow` recipe with the name of the
folder to sync. e.g. to sync `git`, do

```bash
just stow git
```

*Note*: My tmux config uses [`tpm`](https://github.com/tmux-plugins/tpm) to manage plugins. For the configuration to work properly, you will need to enter
tmux and invoke the installation command (`<C-Space> + I`).

That's it!
