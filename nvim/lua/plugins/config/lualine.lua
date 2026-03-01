-- Status bar style
local function process_sections(sections)
    for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for id, comp in ipairs(section) do
            if type(comp) ~= 'table' then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = '' } or { left = '' }
        end
    end
    return sections
end

require("lualine").setup {
    options = {
        theme = 'auto',
        disabled_filetypes = { 'NvimTree', 'vim-plug', 'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dap_repl', 'dapui_console' },
    },
    sections = process_sections {
        lualine_a = { 'mode' },
        lualine_b = { { 'filetype', colored = false } },
        lualine_c = { 'diagnostics' },
        lualine_x = { },
        lualine_y = { 'branch' },
        lualine_z = { 'progress' },
    },
    inactive_sections = {
        lualine_a = { 'fileformat' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'encoding' },
    },
    tabline = {},
    extensions = {},
}

--[[ Credits
https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/slanted-gaps.lua
]]
