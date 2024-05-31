-- Plugins for tools beyond nvim
local leet_arg = "leetcode.nvim"
return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ll", "<cmd>Leet list<cr>", desc = "Leet list" },
      { "<leader>lr", "<cmd>Leet run<cr>", desc = "Leet run" },
      { "<leader>lt", "<cmd>Leet tabs<cr>", desc = "Leet tabs" },
      { "<leader>lc", "<cmd>Leet console<cr>", desc = "Leet console" },
      { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Leet submit" },
      { "<leader>lo", "<cmd>Leet open<cr>", desc = "Leet open" },
    },
    opts = {
      arg = leet_arg,
      --@type lc.lang
      lang = "cpp",
      -- which-key
      function()
        local wk = require("which-key")
        wk.register({
          ["<leader>l"] = {
            name = "Leet",
            l = { "Leet list" },
            r = { "Leet run" },
            t = { "Leet tabs" },
            c = { "Leet console" },
            s = { "Leet submit" },
            o = { "Leet open" },
          },
        })
      end,
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Load obsidian.nvim only for markdown files in vault
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/**.md",
    },
    keys = function()
      return {
        { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
      }
    end,
    dependencies = {
      -- Required
      "nvim-lua/plenary.nvim",
      -- Completion
      "hrsh7th/nvim-cmp",
      -- Picker
      "nvim-telescope/telescope.nvim",
      -- Syntax highlighting
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "Personal",
          path = "~/Obsidian/Personal",
        },
        {
          name = "Work",
          path = "~/Obsidian/Work",
        },
      },
      notes_subdir = "notes",
      daily_notes = {
        folder = "daily",
      },
      new_notes_location = "notes_subdir",
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,
    },
  },
}
