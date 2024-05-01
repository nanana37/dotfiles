# dotfiles

My dotfiles.

- [x] neovim (with [lazy.nvim](https://github.com/folke/lazy.nvim))
- [x] zsh
- [x] tmux
- [ ] bash (relatively slow for git prompt)
- [ ] Wezterm (not yet. See [Considerations for Wezterm](#Considerations-for-Wezterm))

## Installation
```
git clone https://github.com/nanana37/dotfiles.git
cd dotfiles
make install
```

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
