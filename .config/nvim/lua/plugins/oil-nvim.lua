return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" } },
      -- Floating window does not support preview.
      -- [Issue](https://github.com/stevearc/oil.nvim/issues/303) already exisits.
      -- { "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" } },
    },
    opts = {
      keymaps = {
        ["-"] = "actions.close",
        ["q"] = "actions.close",
        ["<BS>"] = "actions.parent",
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["`"] = false,
        ["~"] = false,
        ["<C-g>"] = "actions.cd",
        ["<C-t>"] = "actions.tcd",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return vim.startswith(name, ".git")
        end,
      },
      float = {
        padding = 5,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
