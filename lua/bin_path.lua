local debugpy = os.getenv 'HOME' .. '/debugpy/VENV/bin/python3'

local M = {
    debugpy = debugpy
}

return setmetatable(M, {
    __index = function(_, key)
        local which = vim.fn.system('which ' .. key)
        local path = string.sub(which, 1, -2) -- the last character is \n, remove it
        return path
    end,
})
