require('nvim-treesitter.configs').setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        'r',
        'python',
        'cpp',
        'lua',
        'vim',
        'julia',
        'yaml',
        'toml',
        'json',
        'html',
        'css',
        'javascript',
        'regex',
        'latex',
        'org',
        'markdown',
        'go',
        'sql',
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    -- ignore_install = { "javascript" },

    highlight = {
        enable = true,
        -- `false` will disable the whole extension
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { 'org', 'latex', 'markdown' },
    },

    indent = {
        enable = true,
        disable = { 'python', 'org', 'tex' },
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR><CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['aC'] = '@class.outer',
                ['iC'] = '@class.inner',
                ['ak'] = '@class.outer',
                ['ik'] = '@class.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                ['ac'] = '@conditional.outer',
                ['ic'] = '@conditional.inner',
                ['ie'] = '@call.inner',
                ['ae'] = '@call.outer',
                ['a<Leader>a'] = '@parameter.outer',
                ['i<Leader>a'] = '@parameter.inner',
                -- latex textobjects
                ['a<Leader>lf'] = '@frame.outer',
                ['a<Leader>ls'] = '@statement.outer',
                ['a<Leader>lb'] = '@block.outer',
                ['a<Leader>lc'] = '@class.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']<Leader>c'] = '@class.outer',
                [']k'] = '@class.outer',
                [']l'] = '@loop.outer',
                [']c'] = '@conditional.outer',
                [']e'] = '@call.outer',
                [']a'] = '@parameter.outer',
                -- latex motions
                [']<Leader>lf'] = '@frame.outer',
                [']<Leader>ls'] = '@statement.outer',
                [']<Leader>lb'] = '@block.outer',
                [']<Leader>lc'] = '@class.outer',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']<Leader>C'] = '@class.outer',
                [']K'] = '@class.outer',
                [']L'] = '@loop.outer',
                [']C'] = '@conditional.outer',
                [']E'] = '@call.outer',
                [']A'] = '@parameter.outer',
                -- latex motions
                [']<Leader>lF'] = '@frame.outer',
                [']<Leader>lS'] = '@statement.outer',
                [']<Leader>lB'] = '@block.outer',
                [']<Leader>lC'] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[<Leader>c'] = '@class.outer',
                ['[k'] = '@class.outer',
                ['[l'] = '@loop.outer',
                ['[c'] = '@conditional.outer',
                ['[e'] = '@call.outer',
                ['[a'] = '@parameter.outer',
                -- latex motions
                ['[<Leader>lf'] = '@frame.outer',
                ['[<Leader>ls'] = '@statement.outer',
                ['[<Leader>lb'] = '@block.outer',
                ['[<Leader>lc'] = '@class.outer',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[<Leader>C'] = '@class.outer',
                ['[K'] = '@class.outer',
                ['[L'] = '@loop.outer',
                ['[C'] = '@conditional.outer',
                ['[E'] = '@call.outer',
                ['[A'] = '@parameter.outer',
                -- latex motions
                ['[<Leader>lF'] = '@frame.outer',
                ['[<Leader>lS'] = '@statement.outer',
                ['[<Leader>lB'] = '@block.outer',
                ['[<Leader>lC'] = '@class.outer',
            },
        },
    },

    matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable_virtual_text = true,
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
}
