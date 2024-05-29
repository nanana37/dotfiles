return {
  {
    "folke/zen-mode.nvim",
    keys = function()
      return {
        { "<leader>zz", ":ZenMode<CR>" },
      }
    end,
    opts = {
      plugins = { tmux = true },
    },
  },
  -- {
  --   "folke/twilight.nvim", -- grey out code
  -- },
}
