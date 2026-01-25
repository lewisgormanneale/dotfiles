-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable arrow keys to practice hjkl navigation
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>", { desc = "Disabled" })
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>", { desc = "Disabled" })
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>", { desc = "Disabled" })
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>", { desc = "Disabled" })
