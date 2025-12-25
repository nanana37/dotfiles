# dotfiles

My dotfiles.

[GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) is used to manage symlinks.

- [x] neovim (with [lazy.nvim](https://github.com/folke/lazy.nvim))
- [x] zsh
- [x] tmux
- [ ] bash (relatively slow for git prompt)
- [ ] Wezterm (not yet. See [Considerations for Wezterm](#considerations-for-wezterm))

## Installation

```bash
git clone https://github.com/nanana37/dotfiles.git
cd dotfiles
chmod +x scripts/install.sh
./scripts/install.sh
```

## Migration from old structure

If you have the old structure (`~/.dotfiles`), please follow these steps:

```bash
# 1. Unstow old links (using the old script if available, or manually)
cd ~/.dotfiles
./scripts/stow.sh --unstow

# 2. Rename directory
cd ..
mv .dotfiles dotfiles
cd dotfiles

# 3. Pull latest changes
git pull

# 4. Install
./scripts/install.sh
```

## Supported OS

- macOS (latest)
- Linux (Ubuntu/Debian)


## old version

Previous dotfiles is [here](https://github.com/nanana37/old-dotfiles) (*private repo).

- [x] neovim (with [vim-plug](https://github.com/junegunn/vim-plug))
- [x] zsh
- [x] tmux

## Considerations for Wezterm

Terminal emulator
[wez/wezterm](https://github.com/wez/wezterm)

Pros

- GPU-accelerated
- Cross platform
- Multiplexer (no need for tmux?)
- Customize
  - Lua
  - Rich documents
  - Lots of colorscheme :)

Cons

- vs tmux
  - no popup
  - no kill-session
- vs iTerm
  - no Hotkey
