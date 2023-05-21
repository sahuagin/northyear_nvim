local M = {}
M.config = {}
local bufmap = vim.api.nvim_buf_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local my_augroup = require('conf.builtin_extend').my_augroup

M.config.lspkind = function()
    require('lspkind').init {
        mode = 'symbol_text',
        symbol_map = {
            Number = '󰎠',
            Array = '',
            Variable = '',
            Method = 'ƒ',
            Function = '',
            Property = '',
            Boolean = '⊨',
            Namespace = '',
            Package = '',
        },
    }
end

M.config.signature = function()
    autocmd('LspAttach', {
        group = my_augroup,
        desc = 'Attach signature',
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.signatureHelpProvider then
                require('lsp_signature').on_attach({
                    bind = true, -- This is mandatory, otherwise border config won't get registered.
                    handler_opts = {
                        border = 'double',
                    },
                    floating_window = false,
                    toggle_key = '<A-s>',
                    select_signature_key = '<A-S>',
                    floating_window_off_x = 15, -- adjust float windows x position.
                    floating_window_off_y = 15,
                    hint_enable = false,
                    -- hint_prefix = "",
                    -- doc_lines = 5,
                    time_interval = 100,
                }, bufnr)
            end
        end,
    })
end

M.config.aerial = function()
    require('aerial').setup {
        backends = { 'lsp', 'treesitter', 'markdown' },
        close_automatic_events = { 'unsupported' },
        filter_kind = false,
        show_guides = true,
    }
end

M.config.lspsaga = function()
    local saga = require 'lspsaga'
    saga.setup {
        lightbulb = {
            sign = false,
            virtual_text = false,
        },
        finder = {
            open = { 'o', '<cr>' },
            vsplit = 'v',
            split = 's',
            quit = { 'q', '<ESC>' },
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
        },
        code_action = {
            keys = {
                quit = '<ESC>',
                exec = '<CR>',
            },
        },
        rename = {
            quit = '<ESC>',
            in_select = false,
        },
        diagnostic = {
            keys = {
                exec_action = '<CR>',
            },
        },
        ui = {
            border = 'rounded',
        },
        symbol_in_winbar = {
            enable = false,
        },
    }
end

M.config.refactor = function()
    autocmd('FileType', {
        pattern = { 'go', 'python', 'lua' },
        once = true,
        desc = 'Load refactoring.nvim',
        callback = function()
            require('refactoring').setup {}
            bufmap(
                0,
                'n',
                '<Leader>lr',
                '<CMD>lua require("refactoring").select_refactor()<CR>',
                { desc = 'refactoring' }
            )
            bufmap(0, 'v', '<Leader>lr', ':lua require("refactoring").select_refactor()<CR>', { desc = 'refactoring' })
        end,
    })
end

M.config.nullls = function()
    local null_ls = require 'null-ls'
    local util = require 'null-ls.utils'
    local helper = require 'null-ls.helpers'

    local function root_pattern_wrapper(patterns)
        -- referenced from
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics/flake8.lua
        return helper.cache.by_bufnr(function(params)
            return util.root_pattern('.git', unpack(patterns or {}))(params.bufname)
        end)
    end

    local function source_wrapper(args)
        local source = args[1]
        local patterns = args[2]
        args[1] = nil
        args[2] = nil
        args.cwd = args.cwd or root_pattern_wrapper(patterns)
        return source.with(args)
    end

    local sql_formatter_config_file = os.getenv 'HOME' .. '/.config/sql_formatter/sql_formatter.json'

    null_ls.setup {
        should_attach = function(bufnr)
            return not vim.api.nvim_buf_get_name(bufnr):match 'tmp-%.'
            -- don't start null-ls for those virtual files created by quarto-nvim
            -- which is used for fetching completions from different langauges.
        end,
        fallback_severity = vim.diagnostic.severity.INFO,
        sources = {
            source_wrapper { null_ls.builtins.formatting.stylua, { '.stylua.toml' } },
            source_wrapper { null_ls.builtins.diagnostics.selene, { 'selene.toml' } },
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.refactoring,
            source_wrapper {
                null_ls.builtins.formatting.prettierd,
                { '.prettirrc', '.prettirrc.json', '.prettirrc.yaml' },
                filetypes = { 'markdown.pandoc', 'json', 'markdown', 'rmd', 'yaml', 'quarto' },
            },
            source_wrapper {
                null_ls.builtins.formatting.sql_formatter,
                args = vim.fn.empty(vim.fn.glob(sql_formatter_config_file)) == 0
                        and { '--config', sql_formatter_config_file }
                    or nil,
                -- this expression = 0 means this file exists.
            },
            source_wrapper {
                null_ls.builtins.formatting.yapf,
                { 'pyproject.toml', '.style.yapf' },
            },
            source_wrapper {
                null_ls.builtins.diagnostics.vale,
                { '.vale.ini' },
                filetypes = { 'org', 'markdown', 'markdown.pandoc', 'rmd', 'quarto' },
            },
        },
    }
end

M.config.aerial()
M.config.lspkind()
M.config.lspsaga()
M.config.refactor()
M.config.nullls()
M.config.signature()

return M
