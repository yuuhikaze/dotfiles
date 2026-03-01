require("neodev").setup({
    library = {
        plugins = { "nvim-dap-ui" }
    }
})
local mason = require("mason")
local mason_lsp_installer = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local mason_dap_installer = require("mason-nvim-dap")

-- list: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
-- configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local servers = {
    "mesonlsp",
    "texlab",
    "basedpyright",
    "ruff", -- Fast Python linter/formatter (native LSP server)
    "clangd",
    "csharp_ls",
    "html",
    "cssls",
    "tailwindcss",
    "ts_ls",
    "svelte",
    "jsonls",
    "taplo",
    "vimls",
    "bashls",
    "lua_ls",
    "marksman", -- `root_markers`: { ".marksman.toml", ".git" }
    "matlab_ls",
    "slint_lsp",
    "glsl_analyzer",
    "pbls",
    "lemminx",
    "phpactor",
    "r_language_server",
    "ols",
    "dockerls",
    "docker_compose_language_service",
    "gopls",
    "golangci_lint_ls",
    "postgres_lsp",
    -- "hls", -- HEAVY! ~2GiB
    "zls",
    "nil_ls", -- ensure nix is available on your system
}

-- list: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
-- configuration: https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local debuggers = {
    "bash",
    "codelldb",
    "javadbg",
    "jdtls",
    "javatest"
}

-- list: https://mason-registry.dev/registry/list
-- configuration: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
local tools = {
    "mypy",
    "prettier",
    "google-java-format",
    "shellcheck",
    "shfmt",
    "clang-format",
    "markdownlint",
    -- "fourmolu",
    -- "pint",
    "pgformatter",
    "nixfmt",
}

mason.setup()
mason_lsp_installer.setup({
    ensure_installed = servers,
    automatic_enable = false,
    automatic_installation = true,
})
mason_dap_installer.setup({
    ensure_installed = debuggers,
    automatic_installation = true,
})
mason_tool_installer.setup {
    ensure_installed = tools,
}

local handlers = require("core.lsp.handlers")

-- Server-specific configurations using vim.lsp.config (Neovim 0.11+)
vim.lsp.config('basedpyright', {
    capabilities = handlers.capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
            },
        },
    },
})

vim.lsp.config('lua_ls', {
    capabilities = handlers.capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})

vim.lsp.config('html', {
    capabilities = handlers.capabilities,
    init_options = {
        provideFormatter = false
    },
})

vim.lsp.config('clangd', {
    capabilities = handlers.capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
})

vim.lsp.config('r_language_server', {
    capabilities = handlers.capabilities,
    cmd = { vim.fn.stdpath("data") .. '/mason/bin/r-languageserver' }
})

vim.lsp.config('ruff', {
    capabilities = handlers.capabilities,
    -- Disable hover in ruff to avoid conflicts with basedpyright
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        handlers.on_attach(client, bufnr)
    end,
})

-- Set default capabilities for all other servers
vim.lsp.config('*', {
    capabilities = handlers.capabilities,
})

vim.g.rustaceanvim = {
    server = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        default_settings = {
            ['rust-analyzer'] = {
                cargo = {
                    targetDir = vim.fn.expand('~') .. '/.cargo/rust_analyzer-target'
                },
            },
        },
    }
}

-- Enable all LSP servers (Neovim 0.11+ API)
for _, server in pairs(servers) do
    vim.lsp.enable(server)
end

-- Manual LSP servers (not in mason-lspconfig)
vim.lsp.enable("gdscript")

local installed_null_ls, null_ls = pcall(require, "null-ls")
if not installed_null_ls then
    return
end

local formatting = null_ls.builtins.formatting
local sources = {
    -- Haskell
    -- null_ls.builtins.formatting.fourmolu.with({ extra_args = { "--indentation=4" } }),
    -- SQL
    null_ls.builtins.formatting.pg_format,
    -- Python formatting/linting now handled by ruff LSP server
    -- Java
    formatting.google_java_format.with({ extra_args = { "--aosp" } }),
    -- Shell script
    require("none-ls-shellcheck.diagnostics"),
    require("none-ls-shellcheck.code_actions"),
    formatting.shfmt.with({ extra_args = { "--indent=4", "-ci", "-sr" } }),
    -- Markdown
    formatting.markdownlint.with({ extra_args = { string.format("--config=%s/lua/core/formatters/config/.markdownlint.jsonc", vim.fn.stdpath("config")) } }),
    -- CPP
    formatting.clang_format.with({ extra_args = { string.format("--style=%s", "{IndentWidth: 4, ColumnLimit: 0, IndentCaseLabels: true}") } }),
    -- HTML
    formatting.prettier.with({
        filetypes = { "html" },
        extra_args = { "--tab-width=4" },
    }),
}

null_ls.setup({ sources = sources })
