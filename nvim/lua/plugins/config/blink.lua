local icons = require "core.icons"
local kind_icons = icons.kind

vim.g.cmp_active = true

require('blink.cmp').setup({
    keymap = {
        preset = 'default',

        -- Cycle through completions
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },

        -- Show/hide menu
        ['<C-S-Space>'] = { 'show', 'fallback' },
        ['<C-c>'] = { 'hide', 'fallback' },

        -- Accept with Tab (your preference)
        ['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        -- Enter also accepts
        ['<CR>'] = { 'accept', 'fallback' },

        -- Fix backspace (no calculator!)
        ['<BS>'] = { 'fallback' },

        -- Disable documentation keymaps
        ['<C-b>'] = { 'fallback' },
        ['<C-f>'] = { 'fallback' },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'normal',
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
            },
            snippets = {
                name = 'Snippets',
                module = 'blink.cmp.sources.snippets',
                opts = {
                    friendly_snippets = true,
                    search_paths = { vim.fn.stdpath("data") .. "/lazy/flutter-snippets" },
                },
            },
        },
    },

    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        list = {
            selection = {
                preselect = true,
                auto_insert = true,
            },
        },
        menu = {
            border = 'rounded',
            winhighlight = 'Normal:Background,FloatBorder:TelescopeBorder,CursorLine:TelescopeSelection,Search:None',
            draw = {
                columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
            },
        },
        documentation = {
            auto_show = false,  -- Completely disabled
        },
        ghost_text = {
            enabled = false,  -- Disable to prevent inlay hint conflicts
        },
    },

    signature = {
        enabled = false,  -- Disabled to prevent double border with completion menu
    },

    snippets = {
        expand = function(snippet)
            require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
            if filter and filter.direction then
                return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
        end,
        jump = function(direction)
            require('luasnip').jump(direction)
        end,
    },
})
