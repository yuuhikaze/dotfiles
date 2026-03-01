local preserve_cursor = require("scripts.preserve_cursor")
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function(_)
        preserve_cursor.on_yank()
    end,
})
vim.keymap.set("x", "y", function()
    preserve_cursor.yank()
    vim.cmd("normal! y")
end, { noremap = true, silent = true })

require "scripts.basedpyright"
