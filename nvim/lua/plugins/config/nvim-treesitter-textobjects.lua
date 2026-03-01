require("nvim-treesitter.configs").setup({
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["ac"] = { query = "@block.outer", desc = "Select outer part of a code fence block" },
                ["ic"] = { query = "@block.inner", desc = "Select inner part of a code fence block" },
                ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
            },
        },
    },
})
