local function toggle_basedpyright_type_checking_mode()
    local client = vim.lsp.get_clients({ name = "basedpyright" })[1]
    if not client then
        -- print("Basedpyright not active")
        return
    end

    -- Determine new mode (toggle between standard and recommended)
    local current_mode = client.config.settings.basedpyright.analysis.typeCheckingMode
    local new_mode = (current_mode == "recommended") and "standard" or "recommended"

    -- Update the internal config so it persists for this session
    client.config.settings.basedpyright.analysis.typeCheckingMode = new_mode

    -- Notify the server of the change
    client.notify("workspace/didChangeConfiguration", {
        settings = client.config.settings
    })
    
    print("Basedpyright mode: " .. new_mode)
end

-- Create a command to trigger it
vim.api.nvim_create_user_command("PyrightTCMToggle", toggle_basedpyright_type_checking_mode, {})
