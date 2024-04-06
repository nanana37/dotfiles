return {
  -- clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
      end,
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
        "<leader>cpt",
        function()
          local command = require("copilot.command")
          local client = require("copilot.client")
          if client.is_disabled() then
            command.enable()
            command.status()
          else
            command.disable()
            command.status()
          end
        end,
        mode = "n",
        desc = "Toggle Copilot",
      },
    },
    opts = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>cp"] = {
          name = "Copilot",
          s = { "Status" },
          t = { "Toggle" },
        },
      })
    end,
  },
}
