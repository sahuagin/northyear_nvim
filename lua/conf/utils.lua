local M = {}

M.load = {}
local keymap = vim.api.nvim_set_keymap
local bufmap = vim.api.nvim_buf_set_keymap

M.load.project_nvim = function()
    require('project_nvim').setup {
        detection_methods = { 'pattern' },
        patterns = { '.git', '.svn', 'Makefile', 'package.json', 'NAMESPACE', 'setup.py' },
        show_hidden = true,
    }
end

M.load.mason = function()
    require('mason').setup {}
end

M.load.project_nvim()
M.load.mason()

return M
