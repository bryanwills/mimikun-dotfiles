--ref: https://oroques.dev/2020/01/07/neovim-05.html
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- dps-translate-vim
g.dps_translate_source = "en"
g.dps_translate_target = "ja"
