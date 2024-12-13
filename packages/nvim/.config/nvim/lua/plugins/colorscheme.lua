return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priotiry = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
      return { transparent_background = true }
    end,
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  { "aereal/vim-colors-japanesque", name = "japanesque", priority = 1000 },
}
