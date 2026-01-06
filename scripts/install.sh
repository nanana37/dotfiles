#!/bin/bash
set -e

echo "Installing dotfiles..."

# Check for legacy .dotfiles (migration safeguard)
if [ -e "$HOME/.dotfiles" ] && [ "$(pwd)" != "$HOME/.dotfiles" ]; then
    echo "⚠️  Detected '$HOME/.dotfiles'."
    echo "If you are migrating from the old structure, please ensure you have 'unstowed' the old links first."
    echo "Existing symlinks pointing to ~/.dotfiles will cause conflicts."
    read -p "Have you resolved potential conflicts? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting installation."
        exit 1
    fi
fi

OS="$(uname -s)"
echo "Detected OS: $OS"

if [ "$OS" = "Linux" ]; then
  ### apt (Linux) ###
  if command -v apt &> /dev/null; then
    echo "Using apt..."
    sudo apt update
    sudo apt install -y stow git zsh tmux ripgrep fzf zip bat
    # Note: Some packages might have different names on Ubuntu/Debian, e.g. fd-find instead of fd.
    # Adjusting for common names.
    
    # Install Neovim (AppImage for latest version)
    # LazyVim requires Neovim >= 0.11.2, but apt has older versions
    if ! command -v nvim &>/dev/null || [ "$(nvim --version 2>/dev/null | head -1 | grep -oP 'v0\.\K[0-9]+')" -lt 11 ]; then
      echo "Installing latest Neovim via AppImage..."
      
      # Remove old neovim if installed via apt
      sudo apt remove -y neovim 2>/dev/null || true
      
      # Get latest Neovim version from GitHub API
      echo "Fetching latest Neovim version..."
      NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -oP '"tag_name": "\K[^"]+')
      
      if [ -z "$NVIM_VERSION" ]; then
        echo "Failed to fetch latest version, using v0.11.5 as fallback"
        NVIM_VERSION="v0.11.5"
      fi
      
      # Detect architecture
      ARCH=$(uname -m)
      if [ "$ARCH" = "x86_64" ]; then
        NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage"
      elif [ "$ARCH" = "aarch64" ]; then
        NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-arm64.appimage"
      else
        echo "Unsupported architecture: $ARCH"
        exit 1
      fi
      
      echo "Downloading Neovim ${NVIM_VERSION}..."
      
      # Download Neovim AppImage
      curl -Lo nvim.appimage "$NVIM_URL"
      chmod u+x nvim.appimage
      
      # Move to a standard location
      sudo mkdir -p /opt/nvim
      sudo mv nvim.appimage /opt/nvim/nvim
      
      # Create symlink in PATH
      sudo ln -sf /opt/nvim/nvim /usr/local/bin/nvim
      
      echo "Neovim installed successfully!"
    else
      echo "Neovim is already installed and meets version requirements."
    fi
    
    # Install starship
    if ! command -v starship &>/dev/null; then
      echo "Installing starship..."
      curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
    
    # Install zoxide
    if ! command -v zoxide &>/dev/null; then
      echo "Installing zoxide..."
      curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
  else
    echo "apt not found. Please install dependencies manually."
  fi

elif [ "$OS" = "Darwin" ]; then
  ### brew (macOS) ###
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "Using brew..."
  brew install npm zip git stow
  # Below should be downloaded through brew for me, due to the version.
  # brew install llvm@17
  brew install fzf tmux zsh neovim ripgrep
  
  # Other CLI tools
  brew install bat eza powerlevel10k lazygit
  
  # macOS specific
  brew install --cask karabiner-elements nikitabobko/tap/aerospace ghostty
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# Stow dotfiles
# Stow dotfiles
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/stow.sh"

# tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Set shell
current_shell=$(basename "$SHELL")
if [ "$current_shell" != "zsh" ]; then
  zsh_path=$(which zsh)
  if [ -n "$zsh_path" ]; then
    # Ensure zsh is in /etc/shells (required for chsh)
    if ! grep -q "^$zsh_path$" /etc/shells; then
      echo "Adding $zsh_path to /etc/shells..."
      echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
    fi
    
    echo "Changing shell to zsh..."
    echo "You may be prompted for your password."
    sudo chsh -s "$zsh_path" "$USER"
  fi
fi

echo "Installation complete."
