require('lazy').setup({
    { 'folke/lazy.nvim' },

    { 'milanglacier/smartim' }, -- automatically switch input method when switch mode
    { 'echasnovski/mini.nvim' },

    -- text-editing, motions, jumps tools
    { 'justinmk/vim-sneak' },
    { 'junegunn/vim-easy-align' },
    { 'tpope/vim-repeat', lazy = false },
    { 'michaeljsmith/vim-indent-object', lazy = false },
    { 'AndrewRadev/dsf.vim' },
    { 'gbprod/substitute.nvim' },
    { 'andymass/vim-matchup' },
    { 'tommcdo/vim-exchange', lazy = false },
    { 'kana/vim-textobj-user' },
    { 'D4KU/vim-textobj-chainmember' },
    { 'thinca/vim-textobj-between' },
    { 'monaqa/dial.nvim' },

    -- Tree sitter for enhanced text obj and syntax capturality
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update { sync = true }
        end,
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        },
    },

    { 'nvim-lua/plenary.nvim' },
    -- cli tools

    -- installer
    { 'williamboman/mason.nvim' },
    -- neovim installer that helps you to install external command line
    -- programs

}, {
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
