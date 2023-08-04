local lazy_plugins = {
    { 'folke/lazy.nvim' },

    { 'echasnovski/mini.nvim' },

    -- text-editing, motions, jumps tools
    { 'justinmk/vim-sneak' },
    { 'junegunn/vim-easy-align' },
    { 'tpope/vim-repeat', lazy = false },
    { 'michaeljsmith/vim-indent-object', lazy = false },
    { 'AndrewRadev/dsf.vim' },
    { 'gbprod/substitute.nvim' },
    { 'andymass/vim-matchup', event = 'VeryLazy' },
    { 'tommcdo/vim-exchange', lazy = false },
    { 'kana/vim-textobj-user' },
    { 'D4KU/vim-textobj-chainmember' },
    { 'thinca/vim-textobj-between' },
    { 'monaqa/dial.nvim' },

    -- Tree sitter for enhanced text obj and syntax capturality
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
        },
    },

    { 'nvim-lua/plenary.nvim' },
    -- cli tools
    { 'milanglacier/yarepl.nvim' },

    -- installer
    { 'williamboman/mason.nvim' },
    -- neovim installer that helps you to install external command line
    -- programs
}

require('lazy').setup(lazy_plugins, {
    dev = {
        path = vim.env.HOME .. '/Desktop/personal-projects',
        patterns = { 'milanglacier' },
        fallback = true,
    },
    defaults = {
        lazy = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})
