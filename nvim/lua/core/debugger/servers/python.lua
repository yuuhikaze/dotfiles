local installed, dap = pcall(require, "dap-python")
if not installed then
    return
end

local pythonPath = function()
    -- You could use the `VIRTUAL_ENV` environment variable too.
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. '/env/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
    elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
    else
        return '/usr/bin/python'
    end
end;

dap.setup(pythonPath())
