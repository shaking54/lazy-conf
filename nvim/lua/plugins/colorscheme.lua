return {
  -- Kanagawa colorscheme (dark)
  -- https://dotfyle.com/plugins/rebelot/kanagawa.nvim
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon", -- near-black background. "wave" = dark blue, "lotus" = light
      background = {
        dark = "dragon", -- was "wave" (dark blue); this overrides `theme` when bg is dark
        light = "lotus",
      },
      transparent = false,
    },
  },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
