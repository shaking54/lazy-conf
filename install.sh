#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Core tools ────────────────────────────────────────────────────────────────
echo "Installing packages..."
brew install neovim lazygit fzf tmux

# Ghostty is distributed as a cask
brew install --cask ghostty 2>/dev/null || echo "Ghostty already installed or unavailable via cask — install manually from https://ghostty.org"

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ── Symlink configs ───────────────────────────────────────────────────────────
echo "Linking configs..."

# Neovim
[ -e ~/.config/nvim ] || ln -s "$REPO_DIR/nvim" ~/.config/nvim

# Ghostty
mkdir -p ~/.config/ghostty
[ -e ~/.config/ghostty/config ] || ln -s "$REPO_DIR/ghostty/config" ~/.config/ghostty/config

# lazygit (macOS)
mkdir -p ~/Library/Application\ Support/lazygit
[ -e ~/Library/Application\ Support/lazygit/config.yml ] || \
  ln -s "$REPO_DIR/lazygit/config.yml" ~/Library/Application\ Support/lazygit/config.yml

# Zsh — passion theme + .zshrc
cp "$REPO_DIR/zsh/passion.zsh-theme" ~/.oh-my-zsh/themes/passion.zsh-theme
[ -e ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak && echo "Backed up existing ~/.zshrc to ~/.zshrc.bak"
cp "$REPO_DIR/zsh/.zshrc" ~/.zshrc

echo "Done. Open a new shell or run: source ~/.zshrc"
