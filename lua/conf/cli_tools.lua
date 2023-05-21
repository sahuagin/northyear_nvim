local M = {}
M.config = {}

local keymap = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local my_augroup = require('conf.builtin_extend').my_augroup
local bufcmd = vim.api.nvim_buf_create_user_command
local bufmap = vim.api.nvim_buf_set_keymap

local lazy = require 'lazy'

M.config.gitsigns = function()
    require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    }

    keymap('n', '<Leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { noremap = true })
    keymap('n', '<Leader>gr', '<cmd>Gitsigns reset_hunk<CR>', { noremap = true })
    keymap('n', '<Leader>gs', '<cmd>Gitsigns stage_hunk<CR>', { noremap = true })
    keymap('n', '<Leader>gq', '<cmd>Gitsigns setqflist<CR>', { noremap = true })
    keymap('n', ']h', '<cmd>Gitsigns next_hunk<CR>', { noremap = true })
    keymap('n', '[h', '<cmd>Gitsigns prev_hunk<CR>', { noremap = true })
end

M.config.neogit = function()
    keymap('n', '<Leader>gg', '<cmd>Neogit<CR>', { noremap = true, desc = 'Neogit' })
end

M.config.diffview = function()
    keymap('n', '<Leader>gd', '<cmd>DiffviewOpen<CR>', { noremap = true })
    keymap('n', '<Leader>gf', '<cmd>DiffviewFileHistory<CR>', { noremap = true })
end

M.config.spectre = function()
    require('spectre').setup()

    keymap('n', '<Leader>fR', "<cmd>lua require('spectre').open()<CR>", { noremap = true, desc = 'rg at side panel' })
    keymap(
        'v',
        '<Leader>fR',
        ":<C-U>lua require('spectre').open_visual()<CR>",
        { noremap = true, desc = 'rg at side panel' }
    )
end

M.config.mkdp = function()
    vim.g.mkdp_filetypes = { 'markdown.pandoc', 'markdown', 'rmd', 'quarto' }

    keymap('n', '<Leader>mmp', '<cmd>MarkdownPreview<cr>', { noremap = true, desc = 'Misc Markdown Preview' })
    keymap('n', '<Leader>mmq', '<cmd>MarkdownPreviewStop<cr>', { noremap = true, desc = 'Misc Markdown Preview Stop' })

    lazy.load { plugins = { 'markdown-preview.nvim' } }
end

M.config.iron = function()
    local iron = require 'iron.core'

    local radian = require('iron.fts.r').radian
    local ipython = require('iron.fts.python').ipython
    local aichat = require('iron.fts.markdown').aichat

    iron.setup {
        config = {
            scratch_repl = true,
            repl_definition = {
                r = radian,
                rmd = radian,
                quarto = radian,
                markdown = aichat,
                ['markdown.pandoc'] = aichat,
                python = ipython,
            },
            repl_open_cmd = 'belowright 15 split',
            buflisted = true,
            highlight_last = false,
        },
        keymaps = {
            send_motion = '<LocalLeader>s',
            visual_send = '<LocalLeader>s',
            send_file = '<LocalLeader>sf',
            send_line = '<LocalLeader>ss',
            send_mark = '<LocalLeader>sm',
            cr = '<LocalLeader>s<cr>',
            interrupt = '<LocalLeader>ri',
            exit = '<LocalLeader>rq',
            clear = '<LocalLeader>rc',
        },
    }

    keymap('n', '<localleader>rs', '<cmd>IronRepl<CR>', {})
    keymap('n', '<localleader>rr', '<cmd>IronRestart<CR>', {})
    keymap('n', '<localleader>rh', '<cmd>IronHide<CR>', {})
    keymap('n', '<localleader>rf', '<cmd>IronFocus<CR>', {})
    keymap('n', '<localleader>rw', '<cmd>IronWatch file<CR>', {})
    keymap('n', '<localleader>ra', ':IronAttach', {})
    keymap('n', '<localleader>rg', '<cmd>IronAttach markdown<CR>', { desc = 'Iron attach to chatgpt' })
    -- iron attach will attach current buffer to a running repl
    -- iron focus will reopen a window for current repl if there's no window for repl
    -- iron watch will send the entire file / mark after writing the buffer

    keymap('n', '<localleader>sc', '', {
        desc = 'send a code chunk',
        callback = function()
            local local_leader = vim.g.maplocalleader
            local leader = vim.g.mapleader

            if vim.bo.filetype == 'r' or vim.bo.filetype == 'python' then
                return local_leader .. 'si' .. leader .. 'c'
            elseif vim.bo.filetype == 'rmd' or vim.bo.filetype == 'quarto' or vim.bo.filetype == 'markdown' then
                return local_leader .. 'sic'
                -- Note: in an expression mapping, <LocalLeader>
                -- and <Leader> cannot be automatically mapped
                -- to the corresponding keys, you have to do the mapping manually
            end
        end,
        expr = true,
    })

    autocmd('FileType', {
        pattern = { 'quarto', 'markdown' },
        group = my_augroup,
        desc = 'set up switching iron repls keymap',
        callback = function()
            bufmap(0, 'n', '<LocalLeader>ap', '<cmd>IronAttach python<cr>', { desc = 'switch to python REPL' })
            bufmap(0, 'n', '<LocalLeader>ar', '<cmd>IronAttach quarto<cr>', { desc = 'switch to R REPL' })
        end,
    })
end

M.config.toggleterm = function()
    require('toggleterm').setup {
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.30
            end
        end,
        open_mapping = [[<Leader>ot]],
        shade_terminals = false,
        start_in_insert = false,
        insert_mappings = false,
        terminal_mappings = false,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
    }
    keymap('n', '<Leader>ta', '<cmd>ToggleTermToggleAll<CR>', { silent = true })
    keymap('n', '<Leader>t1', '<cmd>1ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>t2', '<cmd>2ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>t3', '<cmd>3ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>t4', '<cmd>4ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>te', [[<cmd>execute v:count . "TermExec cmd='exit;'"<CR>]], { silent = true })

    autocmd('FileType', {
        desc = 'set command for rendering rmarkdown',
        pattern = 'rmd',
        group = my_augroup,
        callback = function()
            bufcmd(0, 'RenderRmd', function(options)
                local winid = vim.api.nvim_get_current_win()
                ---@diagnostic disable-next-line: missing-parameter
                local current_file = vim.fn.expand '%:.' -- relative path to current wd
                current_file = vim.fn.shellescape(current_file)

                local cmd = string.format([[R --quiet -e "rmarkdown::render(%s)"]], current_file)
                local term_id = options.args ~= '' and tonumber(options.args) or nil

                ---@diagnostic disable-next-line: missing-parameter
                require('toggleterm').exec(cmd, term_id)
                vim.cmd.normal { 'G', bang = true }
                vim.api.nvim_set_current_win(winid)
            end, {
                nargs = '?', -- 0 or 1 arg
            })
        end,
    })

    autocmd('FileType', {
        desc = 'set command for rendering quarto',
        pattern = 'quarto',
        group = my_augroup,
        callback = function()
            bufcmd(0, 'RenderQuarto', function(options)
                local winid = vim.api.nvim_get_current_win()
                ---@diagnostic disable-next-line: missing-parameter
                local current_file = vim.fn.expand '%:.' -- relative path to current wd
                current_file = vim.fn.shellescape(current_file)

                local cmd = string.format([[quarto render %s]], current_file)
                local term_id = options.args ~= '' and tonumber(options.args) or nil

                ---@diagnostic disable-next-line: missing-parameter
                require('toggleterm').exec(cmd, term_id)
                vim.cmd.normal { 'G', bang = true }
                vim.api.nvim_set_current_win(winid)
            end, {
                nargs = '?', -- 0 or 1 arg
            })

            bufcmd(0, 'PreviewQuarto', function(options)
                local winid = vim.api.nvim_get_current_win()
                ---@diagnostic disable-next-line: missing-parameter
                local current_file = vim.fn.expand '%:.' -- relative path to current wd
                current_file = vim.fn.shellescape(current_file)

                local cmd = string.format([[quarto preview %s]], current_file)
                local term_id = options.args ~= '' and tonumber(options.args) or nil

                ---@diagnostic disable-next-line: missing-parameter
                require('toggleterm').exec(cmd, term_id)
                vim.cmd.normal { 'G', bang = true }
                vim.api.nvim_set_current_win(winid)
            end, {
                nargs = '?', -- 0 or 1 arg
            })
        end,
    })
end

M.config.gutentags = function()
    vim.g.gutentags_add_ctrlp_root_markers = 0
    vim.g.gutentags_ctags_exclude = { '.*', '**/.*' }
    vim.g.gutentags_generate_on_new = 0
    vim.g.gutentags_ctags_tagfile = '.tags'
    vim.g.gutentags_ctags_extra_args = { [[--fields=*]] }

    vim.filetype.add {
        pattern = {
            ['%.tags'] = 'tags',
        },
    }

    lazy.load { plugins = { 'vim-gutentags' } }
end

M.config.copilot = function()
    autocmd('InsertEnter', {
        group = my_augroup,
        once = true,
        desc = 'load copilot',
        callback = function()
            require('copilot').setup {
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    debounce = 75,
                    keymap = {
                        accept = '<M-Y>',
                        next = '<M-]>',
                        prev = '<M-[>',
                        dismiss = '<M-q>',
                    },
                },
            }

            keymap('n', '<Leader>tg', '', {
                noremap = true,
                callback = require('copilot.suggestion').toggle_auto_trigger,
                desc = 'toggle copilot',
            })

            keymap('i', '<M-y>', '', {
                noremap = true,
                callback = require('copilot.suggestion').accept_line,
                desc = '[copilot] accept line',
            })
        end,
    })
end

M.config.jupytext = function()
    vim.g.jupytext_enabled = 1
    -- the jupytext_fmt is not flexible enough to support fetch the format
    -- dynamically for example if you want to use jupytext for both python and
    -- R and given two different formats like py:percent and R:percent (or just
    -- auto:percent). Since it is expected that one will use jupyter notebook
    -- mainly for python I will just set the default format to py:percent.

    -- TODO: write a PR to jupytext.vim to support multiple format.
    vim.g.jupytext_fmt = 'py:percent'

    lazy.load { plugins = { 'jupytext.vim' } }
end

M.config.mason = function()
    require('mason').setup {}
end

M.config.diffview()
M.config.gitsigns()
M.config.iron()
M.config.mkdp()
M.config.neogit()
M.config.spectre()
M.config.toggleterm()
M.config.gutentags()
M.config.copilot()
M.config.jupytext()
M.config.mason()

return M
