#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LAZYGIT_CFG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit"
LAZYGIT_MAC_DIR="$HOME/Library/Application Support/lazygit"
GHOSTTY_CFG="$HOME/.config/ghostty/config"
NVIM_CFG="$HOME/.config/nvim"
ZSH_THEME="$HOME/.oh-my-zsh/themes/passion.zsh-theme"

usage() {
  echo "Usage: $0 [save|apply|help]"
  echo "  save   — copy current configs into repo, commit, and push"
  echo "  apply  — pull latest from remote and install configs to system"
  echo "  help   — show this message"
}

save() {
  echo "==> Saving configs to repo..."

  # ghostty
  [ -f "$GHOSTTY_CFG" ] && cp "$GHOSTTY_CFG" "$REPO_DIR/ghostty/config" && echo "  ghostty config"

  # lazygit (macOS first, fallback to XDG)
  if [ -f "$LAZYGIT_MAC_DIR/config.yml" ]; then
    cp "$LAZYGIT_MAC_DIR/config.yml" "$REPO_DIR/lazygit/config.yml" && echo "  lazygit config"
  elif [ -f "$LAZYGIT_CFG_DIR/config.yml" ]; then
    cp "$LAZYGIT_CFG_DIR/config.yml" "$REPO_DIR/lazygit/config.yml" && echo "  lazygit config"
  fi

  # nvim — rsync excludes lazy-lock so plugin versions aren't force-synced
  if [ -d "$NVIM_CFG" ]; then
    rsync -a --delete --exclude="lazy-lock.json" "$NVIM_CFG/" "$REPO_DIR/nvim/" && echo "  nvim config"
  fi

  # zsh passion theme
  [ -f "$ZSH_THEME" ] && cp "$ZSH_THEME" "$REPO_DIR/zsh/passion.zsh-theme" && echo "  zsh passion theme"

  echo "==> Committing and pushing..."
  git -C "$REPO_DIR" add -A
  if git -C "$REPO_DIR" diff --cached --quiet; then
    echo "  nothing changed, skipping commit"
  else
    git -C "$REPO_DIR" commit -m "chore: sync configs $(date '+%Y-%m-%d %H:%M')"
    git -C "$REPO_DIR" push
    echo "==> Done."
  fi
}

apply() {
  echo "==> Pulling latest..."
  git -C "$REPO_DIR" pull --ff-only

  echo "==> Installing configs..."

  # ghostty
  mkdir -p "$(dirname "$GHOSTTY_CFG")"
  cp "$REPO_DIR/ghostty/config" "$GHOSTTY_CFG" && echo "  ghostty → $GHOSTTY_CFG"

  # lazygit
  if [[ "$OSTYPE" == "darwin"* ]]; then
    mkdir -p "$LAZYGIT_MAC_DIR"
    cp "$REPO_DIR/lazygit/config.yml" "$LAZYGIT_MAC_DIR/config.yml" && echo "  lazygit → $LAZYGIT_MAC_DIR/config.yml"
  else
    mkdir -p "$LAZYGIT_CFG_DIR"
    cp "$REPO_DIR/lazygit/config.yml" "$LAZYGIT_CFG_DIR/config.yml" && echo "  lazygit → $LAZYGIT_CFG_DIR/config.yml"
  fi

  # nvim — symlink the whole directory
  if [ -L "$NVIM_CFG" ]; then
    echo "  nvim already symlinked, skipping"
  elif [ -d "$NVIM_CFG" ]; then
    echo "  WARNING: $NVIM_CFG exists and is not a symlink — skipping to avoid overwrite"
  else
    ln -s "$REPO_DIR/nvim" "$NVIM_CFG" && echo "  nvim → $NVIM_CFG (symlinked)"
  fi

  # zsh passion theme
  mkdir -p "$(dirname "$ZSH_THEME")"
  cp "$REPO_DIR/zsh/passion.zsh-theme" "$ZSH_THEME" && echo "  zsh theme → $ZSH_THEME"

  echo "==> Done. Reload your shell: exec zsh"
}

case "${1:-help}" in
  save)  save ;;
  apply) apply ;;
  *)     usage ;;
esac
