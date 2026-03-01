require("bufferline").setup {
    options = {
        numbers = "none",
        indicator = "",
        buffer_close_icon = "✕",
        modified_icon = "⦿",
        close_icon = "✖",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 20,
        enforce_regular_tabs = true,
        diagnostics = false,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = false,
        persist_buffer_sort = true,
        separator_style = "thin",
        always_show_bufferline = true,
        offsets = { { filetype = "NvimTree", text = "" } },
    }
}
