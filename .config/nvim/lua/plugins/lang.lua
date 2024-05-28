return {
  -- markdown
  {
    -- provided in LazyExtras: lang.markdown
    "lukas-reineke/headlines.nvim",

    -- NOTE: A little noisy for me; code block (not-transparent) & headline# marker (overlaps original text)
    enabled = false,

    event = "BufRead",

    -- Mojibake
    ft = function()
      return {}
    end,
    opts = function(_, opts)
      opts.markdown = {
        fat_headline_lower_string = "▔",
      }
      return opts
    end,
  },
}
