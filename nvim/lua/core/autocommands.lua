-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.cmd(
[[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]])

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.cmd(
[[autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])

-- Close tree automatically when it is the last buffer
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

-- Disable folding on alpha buffer
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

-- Change indentation for certain files
vim.cmd([[autocmd FileType json,yaml,xml,nix,dart setlocal smartindent tabstop=2 shiftwidth=2 expandtab]])

-- Disable auto-comment on new line
vim.cmd([[autocmd BufNewFile,BufEnter * setlocal formatoptions-=cro]])

-- Set filetype of jinja template files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.j2",
    callback = function()
        vim.cmd("set filetype=jinja")
    end,
})

local autocmd = vim.api.nvim_create_autocmd
local function autogroup(name, fnc)
    fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Prevent entering buffers in insert mode.
autocmd('WinLeave', {
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
})

-- https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers
local win_is_float = function(winnr)
    local wincfg = vim.api.nvim_win_get_config(winnr)
    if wincfg and (wincfg.external or wincfg.relative and #wincfg.relative > 0) then
        return true
    end
    return false
end
autogroup("ibhagwan/DoNotAutoScroll", function(g)
    autocmd("BufLeave", {
        group = g,
        desc = "Avoid autoscroll when switching buffers",
        callback = function()
            -- at this stage, current buffer is the buffer we leave
            -- but the current window already changed, verify neither
            -- source nor destination are floating windows
            local from_buf = vim.api.nvim_get_current_buf()
            local from_win = vim.fn.bufwinid(from_buf)
            local to_win = vim.api.nvim_get_current_win()
            if not win_is_float(to_win) and not win_is_float(from_win) then
                vim.b.__VIEWSTATE = vim.fn.winsaveview()
            end
        end
    })
    autocmd("BufEnter", {
        group = g,
        desc = "Avoid autoscroll when switching buffers",
        callback = function()
            if vim.b.__VIEWSTATE then
                local to_win = vim.api.nvim_get_current_win()
                if not win_is_float(to_win) then
                    vim.fn.winrestview(vim.b.__VIEWSTATE)
                end
                vim.b.__VIEWSTATE = nil
            end
        end
    })
end)

-- Automatically csvview.nvim with specific flags when entering a CSV file
autocmd("FileType", {
    pattern = "csv",
    callback = function()
        vim.cmd("CsvViewEnable delimiter=, display_mode=border header_lnum=1")
    end,
})
