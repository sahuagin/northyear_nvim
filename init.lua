local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local need_bootstrap = vim.fn.empty(vim.fn.glob(packer_path)) > 0

if need_bootstrap then
    PACKER_BOOTSTRAP_SUCCESS =
        vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path }
    vim.cmd.packadd 'packer.nvim'
    local autocmd = vim.api.nvim_create_autocmd
    autocmd('User', {
        pattern = 'PackerComplete',
        command = 'quitall',
    })
else
    require('impatient').enable_profile()
end

require 'basic_settings'
require 'load_plugins'

if not need_bootstrap then
    require 'load_configs'
end
