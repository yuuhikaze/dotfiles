local installed, dapui = pcall(require, "dapui")
if not installed then
    return
end

local filetype = vim.bo.filetype

local servers = {
    ["java"] = "core.debugger.servers.java",
    ["sh"] = "core.debugger.servers.bash",
    ["python"] = "core.debugger.servers.python",
    ["gdscript"] = "core.debugger.servers.gdscript",
    ["c"] = "core.debugger.servers.c-cpp-rust",
    ["cpp"] = "core.debugger.servers.c-cpp-rust",
    ["rust"] = "core.debugger.servers.c-cpp-rust",
}

local server = servers[filetype]

if server then
    require(server)
else
    print("DAP configuration not available for this filetype")
end

dapui.setup()

local installed_nvim_dap_virtual_text, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not installed_nvim_dap_virtual_text then
    return
end

nvim_dap_virtual_text.setup()
