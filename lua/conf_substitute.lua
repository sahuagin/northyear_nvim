require("substitute").setup()
vim.api.nvim_set_keymap("n", "gs", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "gss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "gS", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.api.nvim_set_keymap("x", "gs", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
