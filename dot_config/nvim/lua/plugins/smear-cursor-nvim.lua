---@type LazySpec
local spec = {
    "sphamba/smear-cursor.nvim",
    --lazy = false,
    cmd = "SmearCursorToggle",
    event = "VimEnter",
    opts = require("plugins.configs.smear-cursor-nvim.opts"),
    -- TODO: NOW fixing scroll speed
    --cond = false,
    --enabled = false,
}

return spec
