require("barbar").setup({
  auto_hide = true,
})

vim.cmd([[
  hi BufferInactive guifg=#808080 guibg=NONE
  hi BufferTabpageFill ctermbg=black
  hi BufferInactiveSign guifg=#808080 guibg=NONE
  hi BufferVisibleSign guifg=#808080 guibg=NONE
]])
