require("zen-mode").setup({
    window = {
        backdrop = 0.95,
        height = 1,
        width = 0.7,
        options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
        },
    },
    plugins = {
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        twilight = { enabled = true },
    },
})
