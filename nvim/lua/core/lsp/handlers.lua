local M = {}

function format_range()
    vim.lsp.buf.format({
        async = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        }
    })
end

local keymaps = function(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gj", ":lua vim.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua Snacks.picker.lsp_definitions()<CR>", opts)        -- jumps to the definition of the symbol under the cursor
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua Snacks.picker.lsp_references()<CR>", opts)         -- lists all the references to the symbl under the cursor in the quickfix window
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":lua Snacks.picker.lsp_implementations()<CR>", opts)    -- lists all the implementations for the symbol under the cursor in the quickfix window
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)            -- selects a code action available at the current cursor position
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)                 -- renaname old_fname to new_fname
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts) -- formats the current buffer
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>lf", ":lua format_range()<CR>", opts) -- formats the current buffer
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", opts)                  -- shows documentation under cursor
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)         -- shows signature under cursor
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", ":lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    keymaps(bufnr)
end

-- LspAttach autocmd for servers using vim.lsp.enable() (e.g., dartls)
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        vim.api.nvim_buf_set_option(event.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
        keymaps(event.buf)
    end
})

-- Get capabilities from blink.cmp (disable snippetSupport to prevent literal parameter insertion)
M.capabilities = require('blink.cmp').get_lsp_capabilities()
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

return M
