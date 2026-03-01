-- require("colorizer").setup({ "*" }, {
--     RGB = true,          -- #RGB hex codes
--     RRGGBB = true,       -- #RRGGBB hex codes
--     names = false,       -- "Name" codes like Blue oe blue
--     RRGGBBAA = true,     -- #RRGGBBAA hex codes
--     rgb_fn = true,       -- CSS rgb() and rgba() functions
--     hsl_fn = false,      -- CSS hsl() and hsla() functions
--     css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--     css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
--     -- Available modes: foreground, background, virtualtext
--     mode = "background", -- Set the display mode.)
-- })
--
-- -- Run colorizer on any file.
-- vim.cmd([[autocmd BufRead,BufWritePre * ColorizerAttachToBuffer]])

require('nvim-highlight-colors').setup({})
