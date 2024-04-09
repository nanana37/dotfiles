return {
  -- clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    keys = {
      {
        "<leader>cps",
        require("copilot.command").status,
        mode = "n",
        desc = "Copilot Status",
      },
      {
        "<leader>cpe",
        function()
          local command = require("copilot.command")
          command.enable()
          command.status()
        end,
        mode = "n",
        desc = "Enable Copilot",
      },
      {
        "<leader>cpd",
        function()
          local command = require("copilot.command")
          command.disable()
          command.status()
        end,
        mode = "n",
        desc = "Disable Copilot",
      },
    },
    opts = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>cp"] = {
          name = "Copilot",
          s = { "Copilot Status" },
          e = { "Enable Copilot" },
          d = { "Disable Copilot" },
        },
      })
    end,
  },
}
