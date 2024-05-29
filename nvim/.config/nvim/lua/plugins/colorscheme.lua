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
}
