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
}
