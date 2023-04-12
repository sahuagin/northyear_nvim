local M = {}
M.load = {}
local bufmap = vim.api.nvim_buf_set_keymap

M.load.lspkind = function()
    require('lspkind').init {
        mode = 'symbol_text',
        symbol_map = {
            Number = '',
            Array = '',
            Variable = '',
            Method = 'ƒ',
            Function = '',
            Property = '',
            Boolean = '⊨',
            Namespace = '',
            Package = '',
        },
    }
end

M.signature = function(bufnr)
    require('lsp_signature').on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = 'double',
        },
        floating_window = false,
        toggle_key = '<A-x>',
        floating_window_off_x = 15, -- adjust float windows x position.
        floating_window_off_y = 15,
        hint_enable = false,
        -- hint_prefix = "",
        -- doc_lines = 5,
        time_interval = 100,
    }, bufnr)
end

M.load.aerial = function()
    require('aerial').setup {
        backends = { 'lsp', 'treesitter', 'markdown' },
        close_automatic_events = { 'unsupported' },
        default_bindings = true,
        filter_kind = false,
        on_attach = function(bufnr)
            bufmap(bufnr, 'n', '<leader>lo', '<cmd>AerialToggle!<CR>', {
                desc = 'lsp symbol outline',
            })
        end,
    }
end

M.load.lspsaga = function()
    local saga = require 'lspsaga'
    saga.setup {
        lightbulb = {
            sign = false,
            virtual_text = true,
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

M.load.refactor = function()
    vim.cmd.packadd { 'refactoring.nvim', bang = true }
    require('refactoring').setup {}
end

M.load.nullls = function()
    vim.cmd.packadd { 'null-ls.nvim', bang = true }

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
                null_ls.builtins.diagnostics.flake8,
                { '.flake8', 'setup.cfg' },
            },
            source_wrapper {
                null_ls.builtins.diagnostics.vale,
                { '.vale.ini' },
                filetypes = { 'org', 'markdown', 'markdown.pandoc', 'rmd', 'quarto' },
            },
        },
    }
end

M.load.aerial()
M.load.lspkind()
M.load.lspsaga()
M.load.refactor()
M.load.nullls()

return M
