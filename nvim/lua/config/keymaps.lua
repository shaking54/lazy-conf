-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle lazygit from anywhere with Ctrl+g (uses snacks.nvim, same engine as <leader>gg)
vim.keymap.set("n", "<C-g>", function()
  Snacks.lazygit()
end, { desc = "Lazygit (root dir)" })
