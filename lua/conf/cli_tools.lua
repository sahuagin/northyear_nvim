local M = {}
M.load = {}

local keymap = vim.api.nvim_set_keymap

M.load.gitsigns = function()
    vim.cmd [[packadd! gitsigns.nvim]]

    require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    }

    keymap('n', '<Leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { noremap = true })
    keymap('n', '<Leader>gq', '<cmd>Gitsigns setqflist<CR>', { noremap = true })
end

M.load.neogit = function()
    vim.cmd [[packadd! neogit]]
end

M.load.diffview = function()
    vim.cmd [[packadd! diffview.nvim]]
end

M.load.spectre = function()
    vim.cmd [[packadd! nvim-spectre]]

    require('spectre').setup()

    keymap('n', '<Leader>rg', "<cmd>lua require('spectre').open()<CR>", { noremap = true })
    keymap('v', '<Leader>rg', "<cmd>lua require('spectre').open_visual()<CR>", { noremap = true })
end

M.load.mkdp = function()
    vim.cmd [[packadd! markdown-preview.nvim]]

    vim.g.mkdp_filetypes = { 'markdown.pandoc', 'markdown', 'rmd' }

    keymap('n', '<LocalLeader>mp', ':MarkdownPreview<cr>', { noremap = true, silent = true })
    keymap('n', '<LocalLeader>mq', ':MarkdownPreviewStop<cr>', { noremap = true, silent = true })
end

M.load.iron = function()
    vim.cmd [[packadd! iron.nvim]]

    local iron = require 'iron'
    local mypath = require 'bin_path'

    vim.g.iron_map_defaults = 0
    vim.g.iron_map_extended = 0

    require('iron.fts.python').ipython.command = mypath.ipython
    local extend = require('iron.util.tables').extend

    local format = function(open, close, cr)
        return function(lines)
            if #lines == 1 then
                return { lines[1] .. cr }
            else
                local new = { open .. lines[1] }
                for line = 2, #lines do
                    table.insert(new, lines[line])
                end
                return extend(new, close)
            end
        end
    end

    iron.core.add_repl_definitions {
        r = {
            radian = {
                command = { mypath.radian },
                format = format('\27[200~', '\27[201~\13', '\13'),
            },
        },

        rmd = {
            radian = {
                command = { mypath.radian },
                format = format('\27[200~', '\27[201~\13', '\13'),
            },
        },
    }

    iron.core.set_config {
        preferred = {
            python = 'ipython',
            r = 'radian',
            rmd = 'radian',
            clojure = 'lein',
        },
        repl_open_cmd = require('iron.view').openwin 'belowright 15 split',
        buflisted = true,
    }

    keymap('n', '<localleader>rs', '<cmd>IronRepl<CR>', {})
    keymap('n', '<localleader>rr', '<cmd>IronRestart<CR>', {})
    keymap('n', '<localleader>ri', '<Plug>(iron-interupt)', {})
    keymap('n', '<localleader>rc', '<Plug>(iron-clear)', {})
    keymap('n', '<localleader>rq', '<Plug>(iron-exit)', {})

    keymap('n', '<localleader>ss', '<Plug>(iron-send-line)', {})
    keymap('n', '<localleader>s', '<Plug>(iron-send-motion)', {})
    keymap('v', '<localleader>ss', '<Plug>(iron-visual-send)', {})

    keymap('n', '<localleader>sc', [[S%%lVs%%l\ss]], {
        desc = 'iron send a code chunk (requires vim-sneak)',
    })
end

M.load.toggleterm = function()
    vim.cmd [[packadd! toggleterm.nvim]]

    require('toggleterm').setup {
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.30
            end
        end,
        open_mapping = [[<Leader>tw]],
        shade_terminals = false,
        start_in_insert = false,
        insert_mappings = false,
        terminal_mappings = false,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
    }
    keymap('n', '<Leader>ta', '<cmd>ToggleTermToggleAll<CR>', { silent = true })
    keymap('n', '<Leader>t2', '<cmd>2ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>t3', '<cmd>3ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>t4', '<cmd>4ToggleTerm<CR>', { silent = true })
    keymap('n', '<Leader>te', [[<cmd>execute v:count . "TermExec cmd='exit;'"<CR>]], { silent = true })

    local autocmd = vim.api.nvim_create_autocmd
    local my_augroup = require('conf.builtin_extend').my_augroup

    autocmd('FileType', {
        desc = 'set command for rendering rmarkdown',
        pattern = 'rmd',
        group = my_augroup,
        callback = function()
            local bufid = vim.api.nvim_get_current_buf()
            local bufcmd = vim.api.nvim_buf_create_user_command

            bufcmd(0, 'RenderRmd', function(options)
                ---@diagnostic disable-next-line: missing-parameter
                local current_file = vim.fn.expand '%:.' -- relative path to current wd
                current_file = vim.fn.shellescape(current_file)

                local cmd = string.format([[R --quiet -e "rmarkdown::render(%s)"]], current_file)
                local term_id = options.args ~= '' and tonumber(options.args) or nil

                ---@diagnostic disable-next-line: missing-parameter
                require('toggleterm').exec(cmd, term_id)

                vim.api.nvim_set_current_buf(bufid)
            end, {
                nargs = '?', -- 0 or 1 arg
            })
        end,
    })
end

M.load.pandoc = function()
    vim.cmd [[packadd! vim-pandoc-syntax]]
    vim.cmd [[packadd! vim-rmarkdown]]

    local autocmd = vim.api.nvim_create_autocmd

    local my_augroup = require('conf.builtin_extend').my_augroup
    autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
        group = my_augroup,
        desc = 'set filetype *.md as markdown.pandoc',
        pattern = '*.md',
        callback = function()
            vim.bo.filetype = 'markdown.pandoc'
        end,
    })

    vim.g.r_indent_align_args = 0
    vim.g.r_indent_ess_comments = 0
    vim.g.r_indent_ess_compatible = 0

    -- vim.g['pandoc#syntax#conceal#blacklist'] = {'subscript', 'superscript', 'atx'}
    vim.g['pandoc#syntax#codeblocks#embeds#langs'] = { 'python', 'R=r', 'r', 'bash=sh', 'json' }
end

M.load.diffview()
M.load.gitsigns()
M.load.iron()
M.load.mkdp()
M.load.neogit()
M.load.spectre()
M.load.toggleterm()
M.load.pandoc()

return M
