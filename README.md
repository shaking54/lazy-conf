# lazy-conf

Personal dotfiles for a unified [Kanagawa Dragon](https://github.com/rebelot/kanagawa.nvim)
themed terminal setup. Bundles the configs for four tools so the terminal,
editor, shell, and git UI all share the same near-black palette.

| Tool | Config in repo | Installs to |
|------|----------------|-------------|
| [LazyVim](https://www.lazyvim.org/) (Neovim) | `nvim/` | `~/.config/nvim` |
| [lazygit](https://github.com/jesseduffield/lazygit) | `lazygit/config.yml` | `~/Library/Application Support/lazygit/config.yml` (macOS)<br>`~/.config/lazygit/config.yml` (Linux) |
| [Ghostty](https://ghostty.org/) | `ghostty/config` | `~/.config/ghostty/config` |
| [Oh My Zsh](https://ohmyz.sh/) | `zsh/` | `~/.zshrc` + `~/.oh-my-zsh/themes/passion.zsh-theme` |

## Highlights

- **Ghostty** uses the built-in `Kanagawa Dragon` theme with zero window padding
  so Neovim fills the whole window.
- **Neovim** runs LazyVim with the `kanagawa` colorscheme (`dragon` variant) and
  a `<C-g>` keymap to toggle lazygit from anywhere via snacks.nvim.
- **lazygit** uses defaults (empty config) and inherits its colors from the
  terminal theme.
- **Zsh** uses the `passion` theme with a custom fzf history widget (`^R`) for
  exact, chronological history search.

## Install

### New machine (one command)

```sh
git clone git@github.com:shaking54/lazy-conf.git
cd lazy-conf
./install.sh
```

`install.sh` will:
1. Install **Homebrew** if missing
2. `brew install` neovim, lazygit, fzf, tmux, ghostty
3. Install **Oh My Zsh** if missing
4. Copy all configs into place, overwriting any existing files

### Manual

```sh
# Neovim (LazyVim)
cp -r nvim ~/.config/nvim

# Ghostty
mkdir -p ~/.config/ghostty
cp ghostty/config ~/.config/ghostty/config

# lazygit (macOS path shown; use ~/.config/lazygit on Linux)
mkdir -p ~/Library/Application\ Support/lazygit
cp lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml

# Zsh
cp zsh/passion.zsh-theme ~/.oh-my-zsh/themes/passion.zsh-theme
cp zsh/.zshrc ~/.zshrc
```

On first launch Neovim will bootstrap lazy.nvim and install all plugins
automatically (versions pinned in `nvim/lazy-lock.json`).
