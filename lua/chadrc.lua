-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	clipboard = "unnamedplus",
    theme = "solarized_dark",
    transparency= true,

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

M.ui = {
  statusline = {
    overriden_modules = function(modules)
      modules[2] = function()
        return vim.fn.expand("%:p")  -- full file path
      end
    end,
  },
}
return M

