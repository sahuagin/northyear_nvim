-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.cmd.packadd { 'nvim-lspconfig', bang = true }
vim.cmd.packadd { 'lspsaga.nvim', bang = true }
vim.cmd.packadd { 'aerial.nvim', bang = true }
vim.cmd.packadd { 'lsp_signature.nvim', bang = true }
vim.cmd.packadd { 'lua-dev.nvim', bang = true }

local opts = function(options)
    return {
        noremap = true,
        silent = true,
        desc = options[1] or options.desc,
        callback = options[2] or options.callback,
    }
end

local bufmap = vim.api.nvim_buf_set_keymap

local on_attach = function(client, bufnr)
    bufmap(bufnr, 'n', '<Leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts { 'lsp type definition' })

    -- reference
    bufmap(
        bufnr,
        'n',
        'gr',
        '',
        opts {
            desc = 'lsp references telescope',
            callback = function()
                require('telescope.builtin').lsp_references {
                    layout_strategies = 'vertical',
                    jump_type = 'tab',
                }
            end,
        }
    )

    bufmap(bufnr, 'n', '<Leader>lF', '<cmd>Lspsaga lsp_finder<CR>', opts { 'lspsaga finder' })

    -- code action
    -- bufmap(bufnr, 'n', '<Leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts {})
    -- bufmap(bufnr, 'v', '<Leader>ca', ":lua require('lspsaga.codeaction').range_code_action()<CR>", opts {})
    bufmap(bufnr, 'n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts { 'lsp code action' })
    bufmap(
        bufnr,
        'x',
        '<Leader>la',
        ':<C-U>lua vim.lsp.buf.range_code_action()<CR>',
        opts {
            'lsp range code action',
        }
    )

    -- hover
    bufmap(bufnr, 'n', 'gh', '<cmd>Lspsaga hover_doc<CR>', opts { 'lspsaga hover doc' })

    -- use glow-hover
    bufmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts { 'lsp hover by glow' })

    -- signaturehelp
    bufmap(
        bufnr,
        'n',
        '<Leader>ls',
        '',
        opts { 'signature help', vim.lsp.buf.signature_help }
    )

    -- rename
    bufmap(bufnr, 'n', '<Leader>ln', '<cmd>Lspsaga rename<CR>', opts { 'lspsaga rename' })

    -- go to definition, implementation
    bufmap(
        bufnr,
        'n',
        'gd',
        '',
        opts {
            desc = 'lsp go to definition',
            callback = function()
                require('telescope.builtin').lsp_definitions {
                    layout_strategies = 'vertical',
                    jump_type = 'tab',
                }
            end,
        }
    )

    bufmap(
        bufnr,
        'n',
        '<Leader>li',
        '',
        opts {
            desc = 'lsp go to implementation',
            callback = function()
                require('telescope.builtin').lsp_implementations {
                    layout_strategies = 'vertical',
                    jump_type = 'tab',
                }
            end,
        }
    )
    bufmap(bufnr, 'n', '<Leader>lD', '<cmd>Lspsaga preview_definition<CR>', opts { 'lspsaga preview definition' })

    -- workspace
    local bufcmd = vim.api.nvim_buf_create_user_command

    bufcmd(bufnr, 'LspWorkspace', function(options)
        if options.args == 'add' then
            vim.lsp.buf.add_workspace_folder()
        elseif options.args == 'remove' then
            vim.lsp.buf.remove_workspace_folder()
        elseif options.args == 'show' then
            vim.pretty_print(vim.lsp.buf.list_workspace_folders())
        end
    end, {
        nargs = 1,
        complete = function(_, _, _)
            return { 'add', 'remove', 'show' }
        end,
    })

    -- format
    bufmap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts { 'lsp format' })
    bufmap(bufnr, 'v', '<Leader>lf', ':<C-U>lua vim.lsp.buf.range_formatting()<CR>', opts { 'lsp range format' })

    -- diagnostic
    bufmap(
        bufnr,
        'n',
        '<Leader>ld',
        '',
        opts { 'lsp diagnostics by telescope', require('telescope.builtin').diagnostics }
    )
    bufmap(bufnr, 'n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts { 'lspsaga prev diagnostic' })
    bufmap(bufnr, 'n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts { 'lspsaga next diagnostic' })
    -- diagnostic show in line or in cursor
    bufmap(bufnr, 'n', '<Leader>ll', '<cmd>Lspsaga show_line_diagnostics<CR>', opts { 'lspsaga line diagnostic' })

    require('aerial').on_attach(client, bufnr)
    require('conf.lsp_tools').signature(bufnr)
end

-- Setup lspconfig.
-- -- -- copied from https://github.com/ray-x/lsp_signature.nvim/blob/master/tests/init_paq.lua
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

-- Copied from lspconfig/server_configurations/pylsp.lua
local function python_root_dir(fname)
    local util = require 'lspconfig.util'
    local root_files = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
    }
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
end

require('lspconfig').pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = python_root_dir,
    settings = {
        python = {
            pythonPath = require('bin_path').python,
        },
    },
    flags = {
        debounce_text_changes = 250,
    },
}

local r_config = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 300,
    },
    capabilities = capabilities,
    settings = {
        r = {
            lsp = {
                -- debug = true,
                log_file = '~/.cache/nvim/r_lsp_log.log',
                lint_cache = true,
                -- max_completions = 40,
            },
        },
    },
}

require('lspconfig').r_language_server.setup(r_config)

require('lspconfig').texlab.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

local clangd_capabilities = vim.deepcopy(capabilities)
clangd_capabilities.offsetEncoding = { 'utf-16' }

require('lspconfig').clangd.setup {
    on_attach = on_attach,
    capabilities = clangd_capabilities,
}

local lua_runtime_path = {}
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

require('lua-dev').setup {}

require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = lua_runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

require('lspconfig').vimls.setup {
    cmd = { require('bin_path')['vim-language-server'], '--stdio' },
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').sqls.setup {
    cmd = { require('bin_path').sqls },
    on_attach = function(client, bufnr)
        vim.cmd.packadd { 'sqls.nvim', bang = true }

        on_attach(client, bufnr)
        require('sqls').on_attach(client, bufnr)
        bufmap(bufnr, 'n', '<LocalLeader>ss', '<cmd>SqlsExecuteQuery<CR>', { silent = true })
        bufmap(bufnr, 'v', '<LocalLeader>ss', '<cmd>SqlsExecuteQuery<CR>', { silent = true })
        bufmap(bufnr, 'n', '<LocalLeader>sv', '<cmd>SqlsExecuteQueryVertical<CR>', { silent = true })
        bufmap(bufnr, 'v', '<LocalLeader>sv', '<cmd>SqlsExecuteQueryVertical<CR>', { silent = true })
    end,
    capabilities = capabilities,
    single_file_support = false,
    on_new_config = function(new_config, new_rootdir)
        new_config.cmd = {
            require('bin_path').sqls,
            '-config',
            new_rootdir .. '/config.yml',
        }
    end,
}

vim.fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '!', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInformation', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

local command = vim.api.nvim_create_user_command

local has_virtual_text = true
local has_underline = true

command('DiagnosticVirtualTextToggle', function()
    has_virtual_text = not has_virtual_text
    vim.diagnostic.config { virtual_text = has_virtual_text }
end, {})

command('DiagnosticUnderlineToggle', function()
    has_underline = not has_underline
    vim.diagnostic.config { underline = has_underline }
end, {})

command('DiagnosticInlineToggle', function()
    vim.cmd.DiagnosticUnderlineToggle()
    vim.cmd.DiagnosticVirtualTextToggle()
end, {})
