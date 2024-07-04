require("core")

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)

-- Habilitar quebra de linha
vim.o.wrap = true

-- Habilitar quebra de linha inteligente, para não quebrar palavras
vim.o.linebreak = true

-- Definir um limite de largura de texto global para quebra de linha
-- vim.o.textwidth = 120

require("plugins")

local function is_wsl()
  local uname = vim.fn.system("uname -r")
  return uname:find("microsoft") ~= nil
end

if is_wsl() then
  vim.api.nvim_create_augroup("Yank", { clear = true })
  vim.api.nvim_create_augroup("TextYankPost", {
    group = "Yank",
    pattern = "*",
    callback = function()
      vim.fn.system("/mnt/c/windows/system32/clip.exe ", vim.fn.getreg('"'))
    end,
  })
end
