local M = {}
M.load = {}

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
        close_behavior = 'close',
        default_bindings = true,
        filter_kind = false,
        on_attach = function(bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', '<cmd>AerialToggle!<CR>', {})
        end,
    }
end

M.load.lspsaga = function()
    local saga = require 'lspsaga'
    saga.setup {
        finder_action_keys = {
            open = { 'o', '<cr>' },
            vsplit = 'v',
            split = 's',
            quit = { 'q', '<ESC>' },
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
            -- quit can be a table
        },
        code_action_keys = {
            quit = { 'q', '<ESC>' },
            exec = '<CR>',
        },
        rename_action_keys = {
            quit = { '<C-c>', '<ESC>' },
            exec = '<CR>', -- quit can be a table
        },
        code_action_prompt = { enable = false },
        max_preview_lines = 100,
    }
end

M.load.glow_hover = function()
    vim.cmd [[packadd! glow-hover]]

    require('glow-hover').setup {
        max_width = 90,
        padding = 5,
        border = 'shadow',
        glow_path = 'glow',
    }
end

M.load.refactor = function()
    vim.cmd [[packadd! refactoring.nvim]]
    require('refactoring').setup {}
end

M.load.nullls = function()
    vim.cmd [[packadd! null-ls.nvim]]

    local null_ls = require 'null-ls'
    local mypath = require 'bin_path'

    null_ls.setup {
        sources = {
            null_ls.builtins.formatting.stylua.with {
                command = mypath.stylua,
            },
            null_ls.builtins.diagnostics.selene.with {
                command = mypath.selene,
            },
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.proselint.with {
                command = mypath.proselint,
                filetypes = { 'markdown', 'markdown.pandoc', 'tex', 'rmd' },
            },
            null_ls.builtins.diagnostics.proselint.with {
                command = mypath.proselint,
                filetypes = { 'markdown', 'markdown.pandoc', 'tex', 'rmd' },
            },
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.diagnostics.codespell.with {
                command = mypath.codespell,
                disabled_filetypes = { 'NeogitCommitMessage' },
            },
            null_ls.builtins.diagnostics.chktex,
            null_ls.builtins.formatting.prettierd.with {
                filetypes = { 'markdown.pandoc', 'json', 'markdown', 'rmd', 'yaml' },
            },
            null_ls.builtins.formatting.sqlfluff.with {
                command = mypath.sqlfluff,
                args = { 'fix', '--dialect', 'mysql', '--disable_progress_bar', '-f', '-n', '-' },
            },
            -- null_ls.builtins.diagnostics.sqlfluff.with {
            --     command = mypath.sqlfluff,
            --     args = { 'lint', '--dialect', 'mysql', '-f', 'github-annotation', '-n', '--disable_progress_bar', '-' },
            -- },
        },
    }
end

M.load.aerial()
M.load.glow_hover()
M.load.lspkind()
M.load.lspsaga()
M.load.refactor()
M.load.nullls()

return M
