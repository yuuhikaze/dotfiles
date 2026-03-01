local installed, dap = pcall(require, "dap")
if not installed then
    return
end

dap.adapters.godot = {
    type = "server",
    host = '127.0.0.1',
    port = 6006, -- Must match the value in Editor → Editor Settings → Network → Debug Adapter
}

dap.configurations.gdscript = {
    {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
    }
}
