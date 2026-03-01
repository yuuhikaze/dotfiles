require("Comment").setup {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = "<leader>cs",
        block = "<leader>cm",
    },
    opleader = {
        line = "<leader>cs",
        block = "<leader>cm",
    },
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    pre_hook = nil,
    post_hook = nil,
}
