-- Plugins that jump between files and directories.
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
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
        ["<C-t>"] = "actions.select_vsplit",
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
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
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },
}
