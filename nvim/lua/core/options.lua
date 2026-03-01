local options = {
    -- Text
    tabstop = 4,
    shiftwidth = 4,
    smartindent = true,
    expandtab = true,
    wrap = false,
    ignorecase = true,
    signcolumn = "yes",
    syntax = "enable",
    -- Interface
    termguicolors = true,
    background = "dark",
    number = true,
    relativenumber = true,
    breakindent = true,
    cursorline = true,
    sidescrolloff = 20,
    cmdheight = 1,
    showmode = false,
    splitbelow = true,
    splitright = true,
    list = true,
    listchars = "tab:» ,extends:›,precedes:‹,nbsp:¤,trail:·,leadmultispace:···◦",
    -- Input
    mouse = "a",
    clipboard = "unnamedplus",
    -- keymap = "kana",
    -- iminsert = 0,
    -- imsearch = -1,
    -- File handling
    swapfile = false,
    backup = false,
    writebackup = false,
    -- Responsiveness
    updatetime = 300, -- faster completion (4000ms default)
}

vim.opt.fillchars = {
    eob = " ",
    vert = " ",
}
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.filetype.add({
    extension = {
        slint = 'slint',
    }
})

vim.lsp.inlay_hint.enable(true)
vim.lsp.enable("dartls")
