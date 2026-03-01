local dap = require('dap')

dap.adapters.codelldb = {
    type = 'executable',
    command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
}

local default_options = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    }
}

dap.configurations.cpp = vim.tbl_deep_extend("force", default_options, {
    {
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end
    },
})

dap.configurations.rust = vim.tbl_deep_extend("force", default_options, {
    {
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end
    }
})

dap.configurations.c = dap.configurations.cpp
