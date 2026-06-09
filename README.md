# lazy-conf

Personal dotfiles for a unified [Kanagawa Dragon](https://github.com/rebelot/kanagawa.nvim)
themed terminal setup. Bundles the configs for three tools so the terminal,
editor, and git UI all share the same near-black palette.

| Tool | Config in repo | Installs to |
|------|----------------|-------------|
| [LazyVim](https://www.lazyvim.org/) (Neovim) | `nvim/` | `~/.config/nvim` |
| [lazygit](https://github.com/jesseduffield/lazygit) | `lazygit/config.yml` | `~/Library/Application Support/lazygit/config.yml` (macOS)<br>`~/.config/lazygit/config.yml` (Linux) |
| [Ghostty](https://ghostty.org/) | `ghostty/config` | `~/.config/ghostty/config` |

## Highlights

- **Ghostty** uses the built-in `Kanagawa Dragon` theme with zero window padding
  so Neovim fills the whole window.
- **Neovim** runs LazyVim with the `kanagawa` colorscheme (`dragon` variant) and
  a `<C-g>` keymap to toggle lazygit from anywhere via snacks.nvim.
- **lazygit** uses defaults (empty config) and inherits its colors from the
  terminal theme.

## Install

Clone and symlink (or copy) each directory into place:

```sh
git clone git@github.com:shaking54/lazy-conf.git
cd lazy-conf

# Neovim (LazyVim)
ln -s "$PWD/nvim" ~/.config/nvim

# Ghostty
mkdir -p ~/.config/ghostty
ln -s "$PWD/ghostty/config" ~/.config/ghostty/config

# lazygit (macOS path shown; use ~/.config/lazygit on Linux)
mkdir -p ~/Library/Application\ Support/lazygit
ln -s "$PWD/lazygit/config.yml" ~/Library/Application\ Support/lazygit/config.yml
```

On first launch Neovim will bootstrap lazy.nvim and install all plugins
automatically (versions pinned in `nvim/lazy-lock.json`).
