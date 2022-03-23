local M = {}

function M.MoveToPrevTab()
    if vim.fn.tabpagenr '$' == 1 and vim.fn.winnr '$' == 1 then
        return
    end

    local tab_nr = vim.fn.tabpagenr '$'
    local cur_buf = vim.fn.bufnr '%'

    if vim.fn.tabpagenr() ~= 1 then
        vim.cmd 'close!'
        if tab_nr == vim.fn.tabpagenr '$' then
            vim.cmd 'tabprev'
        end
        vim.cmd 'sp'
    else
        vim.cmd 'close!'
        vim.cmd '0tabnew'
    end

    vim.cmd('b' .. cur_buf)
end

function M.MoveToNextTab()

    if vim.fn.tabpagenr '$' == 1 and vim.fn.winnr '$' == 1 then
        return
    end

    local tab_nr = vim.fn.tabpagenr '$'
    local cur_buf = vim.fn.bufnr '%'

    if vim.fn.tabpagenr() < tab_nr then
        vim.cmd 'close!'
        if tab_nr == vim.fn.tabpagenr '$' then
            vim.cmd 'tabnext'
        end
        vim.cmd 'sp'
    else
        vim.cmd 'close!'
        vim.cmd 'tabnew'
    end

    vim.cmd('b' .. cur_buf)
end

local keymap = vim.api.nvim_set_keymap

keymap('n', '<A-f>', [[<cmd>lua require("conf.move_tabs").MoveToNextTab()<CR>]], {noremap = true})
keymap('n', '<A-b>', [[<cmd>lua require("conf.move_tabs").MoveToPrevTab()<CR>]], {noremap = true})

keymap('n', '<A-w>', [[<C-w>w]], {noremap = true})
keymap('n', '<A-t>', [[<C-w>T]], {noremap = true})
keymap('n', '<A-q>', [[<C-w>q]], {noremap = true})
keymap('n', '<A-v>', [[<C-w>v]], {noremap = true})
keymap('n', '<A-h>', [[<C-w>h]], {noremap = true})
keymap('n', '<A-j>', [[<C-w>j]], {noremap = true})
keymap('n', '<A-k>', [[<C-w>k]], {noremap = true})
keymap('n', '<A-l>', [[<C-w>l]], {noremap = true})
keymap('n', '<A-H>', [[<C-w>H]], {noremap = true})
keymap('n', '<A-J>', [[<C-w>J]], {noremap = true})
keymap('n', '<A-K>', [[<C-w>K]], {noremap = true})
keymap('n', '<A-L>', [[<C-w>L]], {noremap = true})

return M
