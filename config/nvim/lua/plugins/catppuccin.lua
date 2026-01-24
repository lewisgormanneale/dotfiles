require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = false,
  term_colors = true,
  integrations = {
    telescope = true,
    treesitter = true,
    gitsigns = true,
    cmp = true,
    lsp_trouble = true,
    which_key = true,
    mason = true,
  },
})
