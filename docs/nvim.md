# Neovim profile

- Plugin manager: lazy.nvim (auto-bootstraps).
- Theme: Catppuccin Mocha.
- LSP: mason + mason-lspconfig auto-installs `lua_ls`, `bashls`, `jsonls`, `yamlls`, `tsserver`, `pyright`.
- Completion: nvim-cmp + LuaSnip (+ friendly-snippets).
- Fuzzy: telescope + fzf-native.
- UI: lualine, which-key, gitsigns, autopairs, Comment.nvim.
- Treesitter: auto-updated core languages.

Keymaps (leader = space):
- `<leader>ff` find files, `<leader>fg` live grep, `<leader>fb` buffers
- `gd`/`gr`/`K` goto definition/references/hover
- `<leader>rn` rename, `<leader>ca` code action

Usage:
```sh
nvim --headless "+Lazy! sync" +qa   # install/update plugins
```
