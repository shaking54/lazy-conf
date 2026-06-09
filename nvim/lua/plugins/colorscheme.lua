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
    config = function(_, opts)
      require("kanagawa").setup(opts)
      local function apply_monokai_syntax()
        local hl = vim.api.nvim_set_hl
        -- keywords (vivid pink)
        hl(0, "Keyword",                    { fg = "#ff1f5e", bold = true })
        hl(0, "Conditional",                { fg = "#ff1f5e", bold = true })
        hl(0, "Repeat",                     { fg = "#ff1f5e", bold = true })
        hl(0, "Statement",                  { fg = "#ff1f5e" })
        hl(0, "Exception",                  { fg = "#ff1f5e" })
        hl(0, "@keyword",                   { fg = "#ff1f5e", bold = true })
        hl(0, "@keyword.function",          { fg = "#ff1f5e", bold = true })
        hl(0, "@keyword.return",            { fg = "#ff1f5e", bold = true })
        hl(0, "@keyword.operator",          { fg = "#ff1f5e" })
        hl(0, "@conditional",               { fg = "#ff1f5e", bold = true })
        hl(0, "@repeat",                    { fg = "#ff1f5e", bold = true })
        -- functions (bright lime green)
        hl(0, "Function",                   { fg = "#c2f060" })
        hl(0, "@function",                  { fg = "#c2f060" })
        hl(0, "@function.call",             { fg = "#c2f060" })
        hl(0, "@function.builtin",          { fg = "#c2f060" })
        hl(0, "@method",                    { fg = "#c2f060" })
        hl(0, "@method.call",               { fg = "#c2f060" })
        -- strings (bright yellow)
        hl(0, "String",                     { fg = "#ffe566" })
        hl(0, "@string",                    { fg = "#ffe566" })
        hl(0, "@string.escape",             { fg = "#ff9f3f" })
        -- numbers/booleans (bright purple)
        hl(0, "Number",                     { fg = "#c8b8ff" })
        hl(0, "Float",                      { fg = "#c8b8ff" })
        hl(0, "Boolean",                    { fg = "#c8b8ff" })
        hl(0, "@number",                    { fg = "#c8b8ff" })
        hl(0, "@float",                     { fg = "#c8b8ff" })
        hl(0, "@boolean",                   { fg = "#c8b8ff" })
        -- types (bright cyan)
        hl(0, "Type",                       { fg = "#4de8f5" })
        hl(0, "StorageClass",               { fg = "#4de8f5" })
        hl(0, "@type",                      { fg = "#4de8f5" })
        hl(0, "@type.builtin",              { fg = "#4de8f5" })
        hl(0, "@type.definition",           { fg = "#4de8f5" })
        -- variables/identifiers (bright white)
        hl(0, "Identifier",                 { fg = "#ffffff" })
        hl(0, "@variable",                  { fg = "#ffffff" })
        hl(0, "@variable.builtin",          { fg = "#c8b8ff" })
        hl(0, "@property",                  { fg = "#ffffff" })
        -- parameters (bright orange)
        hl(0, "@parameter",                 { fg = "#ff8c3a" })
        hl(0, "@variable.parameter",        { fg = "#ff8c3a" })
        -- special/macros/preprocessor (orange)
        hl(0, "Special",                    { fg = "#ff9f3f" })
        hl(0, "PreProc",                    { fg = "#ff9f3f" })
        hl(0, "Macro",                      { fg = "#ff9f3f" })
        -- operators (vivid pink)
        hl(0, "Operator",                   { fg = "#ff1f5e" })
        hl(0, "@operator",                  { fg = "#ff1f5e" })
        -- punctuation/delimiters (lighter gray)
        hl(0, "Delimiter",                  { fg = "#b0aeb0" })
        hl(0, "@punctuation.delimiter",     { fg = "#b0aeb0" })
        hl(0, "@punctuation.bracket",       { fg = "#b0aeb0" })
        -- comments (visible gray, italic)
        hl(0, "Comment",                    { fg = "#8c8a8c", italic = true })
        hl(0, "@comment",                   { fg = "#8c8a8c", italic = true })
      end
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "kanagawa*",
        callback = apply_monokai_syntax,
      })
    end,
  },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
