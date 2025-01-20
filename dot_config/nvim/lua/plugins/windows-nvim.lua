-- https://github.com/anuvyklack/middleclass
-- https://github.com/anuvyklack/animation.nvim

---@type LazySpec[]
local dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
}

---@type table
local cmds = {
    "WindowsMaximize",
    "WindowsMaximizeVertically",
    "WindowsMaximizeHorizontally",
    "WindowsEqualize",
    "WindowsEnableAutowidth",
    "WindowsDisableAutowidth",
    "WindowsToggleAutowidth",
}

---@type table
local opts = {
    ignore = {
        buftype = {
            "quickfix",
        },
        filetype = {
            "NvimTree",
            "neo-tree",
            "undotree",
            "gundo",
        },
    },
    animation = {
        enable = true,
        duration = 300,
        fps = 30,
        easing = "in_out_sine",
    },
}

---@type LazySpec
local spec = {
    "anuvyklack/windows.nvim",
    --lazy = false,
    cmd = cmds,
    dependencies = dependencies,
    init = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
    end,
    opts = opts,
    -- TODO: parts of winbuf-manage head
    cond = false,
    enabled = false,
}

return spec
