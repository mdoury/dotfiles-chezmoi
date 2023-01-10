-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { silent = true, remap = false, desc = "Enter Normal Mode" })
vim.keymap.set({ "i", "v" }, "kj", "<Esc>", { silent = true, remap = false, desc = "Enter Normal Mode" })

vim.keymap.set("i", "<C-h>", "<Left>", { silent = true, remap = false, desc = "Move Cursor Left" })
vim.keymap.set("i", "<C-j>", "<Down>", { silent = true, remap = false, desc = "Move Cursor Down" })
vim.keymap.set("i", "<C-k>", "<Up>", { silent = true, remap = false, desc = "Move Cursor Up" })
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true, remap = false, desc = "Move Cursor Right" })
vim.keymap.set("i", "<C-b>", "<C-o>b", { silent = true, remap = false, desc = "Move Cursor Back One Word" })
vim.keymap.set("i", "<C-w>", "<C-o>w", { silent = true, remap = false, desc = "Move Cursor Forward One Word" })

vim.keymap.set("n", "∆", ":m .+1<CR>==", { silent = true, remap = false, desc = "Move down" })
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", { silent = true, remap = false, desc = "Move down" })
vim.keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi", { silent = true, remap = false, desc = "Move down" })
vim.keymap.set("n", "˚", ":m .-2<CR>==", { silent = true, remap = false, desc = "Move up" })
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", { silent = true, remap = false, desc = "Move up" })
vim.keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi", { silent = true, remap = false, desc = "Move up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, remap = false, desc = "which_key_ignore" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, remap = false, desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>fs", "<Cmd>w<CR>", { silent = true, remap = false, desc = "Save file" })
