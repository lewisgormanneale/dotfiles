require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "bash", "markdown", "json", "yaml", "python", "typescript" },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    },
  },
})
