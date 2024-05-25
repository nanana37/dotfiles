-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Resize Window Height & Width
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
vim.keymap.set("n", "<A-Up>", "<cmd>res +5<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<A-Down>", "<cmd>res -5<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<A-Right>", "<cmd>vert res +5<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<A-Left>", "<cmd>vert res -5<cr>", { desc = "Decrease Window Width" })
