local installed, dap = pcall(require, "dap")
if not installed then
    return
end

dap.adapters.bashdb = {
    type = 'executable',
    command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
    name = 'bashdb',
}

dap.configurations.sh = {
    {
        type = 'bashdb',
        request = 'launch',
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
        trace = true,
        program = "${file}",
        args = function()
            local input = vim.fn.input('Enter options/flags: ')
            local args = {}
            for arg in input:gmatch("%S+") do
                table.insert(args, arg)
            end
            return args
        end,
        cwd = '${workspaceFolder}',
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        env = {},
        terminalKind = "integrated",
    }
}
