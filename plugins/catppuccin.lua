return {
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
      })
    end,
    dim_inactive = { enabled = true, percentage = 0.25 },
    integrations = {
      mason = true,
      neotree = true,
      notify = true,
      sandwich = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      ts_rainbow2 = true,
      which_key = true,
    }
  },
}
