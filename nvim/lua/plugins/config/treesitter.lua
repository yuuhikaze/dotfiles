local parsers = {
    "query",
    "python",
    "meson",
    "c",
    "cpp",
    "c_sharp",
    "java",
    "kotlin",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "jsonc",
    "toml",
    "yaml",
    "markdown",
    -- https://www.reddit.com/r/neovim/comments/1psyhxj/neovim_treesitter_error_invalid_node_type_when/
    -- "vim",
    -- "vimdoc",
    "slint",
    "bash",
    "lua",
    "glsl",
    "gdscript",
    "mermaid",
    "latex",
    "rust",
    "go",
    "gomod",
    "gosum",
    -- "sql",
    "smali",
    "svelte",
    "proto",
    "powershell",
    "ini",
    "csv",
    "markdown_inline",
    "r",
    "rnoweb",
    "odin",
    "dockerfile",
    "pem",
    "haskell",
    "xml",
    "gitignore",
    "zig",
    "nix",
    "matlab",
    "jinja",
    "jinja_inline",
    "nu",
    "dart",
}

require("nvim-treesitter").setup({
    ensure_installed = parsers,
})

vim.treesitter.language.register("bash", "zsh")

-- Enable treesitter-based features
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
