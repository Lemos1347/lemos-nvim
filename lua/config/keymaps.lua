-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local maximized = false

-- Remove default <leader>l -> Lazy mapping (use :Lazy instead)
vim.keymap.del("n", "<leader>l")

-- LSP diagnostics
map("n", "<leader>la", vim.diagnostic.setloclist, { desc = "LSP: All Problems" })
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "LSP: Line Diagnostics" })

-- Window splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>se", function()
  if maximized then
    vim.cmd("tabclose")
    maximized = false
  end
  vim.cmd("wincmd =")
end, { desc = "Equalize Splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Split" })

-- Copy all file content
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy Entire File" })

-- Format with conform
map({ "n", "v" }, "<leader>mp", function()
  require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
end, { desc = "Format File/Selection" })

-- LSP restart
map("n", "<leader>lsrs", "<cmd>LspRestart<CR>", { desc = "LSP: Restart Server" })

-- Toggle inlay hints
map("n", "<leader>in", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "LSP: Toggle Inlay Hints" })

-- Find word (grep)
map("n", "<leader>fw", function()
  Snacks.picker.grep()
end, { desc = "Find Word (Grep)" })

-- Navigate buffer tabs
map("n", "<A-,>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<A-.>", "<cmd>bnext<CR>", { desc = "Next Buffer" })

-- Close current buffer
map("n", "<A-w>", function()
  Snacks.bufdelete()
end, { desc = "Close Buffer" })

-- Pick window to focus (shows A, B, C labels on splits)
map("n", "<leader>wp", function()
  local picked = require("window-picker").pick_window()
  if picked then
    vim.api.nvim_set_current_win(picked)
  end
end, { desc = "Pick Window" })

-- Comment toggle (like old config's <leader>/)
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle Comment", remap = true })

-- Delete/Change without copying (black hole register)
-- This covers all motions: dd, diw, daw, di(, da", ciw, ci(, etc.
map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
map({ "n", "v" }, "c", '"_c', { desc = "Change without yanking" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Paste without overwriting register (in visual mode)
map("x", "p", '"_dP', { desc = "Paste without yanking replaced text" })

-- Maximize/restore split (tab-based toggle for full maximize)
map("n", "<leader>sm", function()
  if maximized then
    vim.cmd("tabclose")
    maximized = false
  else
    vim.cmd("tab split")
    maximized = true
  end
end, { desc = "Maximize/Restore Split" })
