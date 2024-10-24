---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "ayu_dark",
  transparency = true,
  tabufline = {
    enabled = false,
  },
  statusline = {
    theme = "minimal",
    overriden_modules = function(modules)
      -- Helper function to check if a macro is being recorded
      local function get_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register ~= "" then
          -- Wrap the recording indicator in a highlight group
          return "%#RecordingStatus#" .. " ● Recording @" .. recording_register .. "  " .. "%*"
        end
        return ""
      end

      -- Get the current mode string from modules[6], the file encoding -- check modules: https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/minimal.lua
      local mode_str = modules[6] or ""

      -- Append the macro recording indicator if recording
      local macro_recording = get_macro_recording()
      if macro_recording ~= "" then
        mode_str = mode_str .. macro_recording
      end

      modules[6] = mode_str

      -- Define the highlight group for the "Recording" text
      vim.api.nvim_set_hl(0, "RecordingStatus", { fg = "#ffffff", bold = true })
    end,
  },
}

return M
