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

brew install --cask ghostty 2>/dev/null || echo "Ghostty unavailable via cask — install manually from https://ghostty.org"

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ── Copy configs (overwrite) ──────────────────────────────────────────────────
echo "Installing configs..."

# Neovim
rm -rf ~/.config/nvim
cp -r "$REPO_DIR/nvim" ~/.config/nvim

# Ghostty
mkdir -p ~/.config/ghostty
cp "$REPO_DIR/ghostty/config" ~/.config/ghostty/config

# lazygit (macOS)
mkdir -p ~/Library/Application\ Support/lazygit
cp "$REPO_DIR/lazygit/config.yml" ~/Library/Application\ Support/lazygit/config.yml

# Zsh
cp "$REPO_DIR/zsh/passion.zsh-theme" ~/.oh-my-zsh/themes/passion.zsh-theme
cp "$REPO_DIR/zsh/.zshrc.shared" ~/.zshrc.shared
if ! grep -q 'source ~/.zshrc.shared' ~/.zshrc 2>/dev/null; then
  echo 'source ~/.zshrc.shared' >> ~/.zshrc
fi

echo "Done. Open a new shell or run: source ~/.zshrc"
