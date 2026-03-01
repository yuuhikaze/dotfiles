require("snacks").setup({
    -- Core modules
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },

    -- Styles
    styles = {
        notification = {
            wo = { wrap = true },
            border = "rounded",
        },
    },

    -- Dashboard
    dashboard = {
        enabled = true,
        preset = {
            header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
            keys = {
                { icon = "", key = "f", desc = "Find Files", action = ":lua Snacks.picker.files()" },
                { icon = "", key = "o", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
                { icon = "", key = "w", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
                { icon = "", key = "e", desc = "New File", action = ":ene | startinsert" },
                { icon = "󰆓 ", key = "s", desc = "Find Session", action = ":SessionManager load_session" },
                { icon = "", key = "i", desc = "Settings", action = ":e ~/.config/nvim/init.lua" },
                { icon = "", key = "q", desc = "Quit", action = ":qa" },
            },
        },
    },

    -- Picker configuration
    picker = {
        -- Close on single ESC press
        win = {
            input = {
                keys = {
                    ["<Esc>"] = { "close", mode = { "n", "i" } },
                },
            },
        },
    },
})
