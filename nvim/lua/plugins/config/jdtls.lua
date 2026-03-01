-- credits: https://github.com/neovim/nvim-lspconfig/issues/1633, https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
local M = {}

local handlers = require("core.lsp.handlers")

M.config = {
    settings = {
        java = {
            format = {
                settings = {
                    url = vim.fn.stdpath("config") .. "/lua/core/formatters/config/jdtls.xml"
                },
            },
        },
    },
    cmd = { vim.fn.stdpath("data") .. '/mason/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    init_options = {
        bundles = {
            vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true ),
            vim.fn.glob(vim.fn.stdpath("data") .. "mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
        }
    },
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}

return M
