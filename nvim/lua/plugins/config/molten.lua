-- Molten configuration for Jupyter notebook integration
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_win_max_height = 20
vim.g.molten_auto_open_output = false
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true

-- Keymaps
local opts = { noremap = true, silent = true }

-- Initialize kernel
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Initialize kernel" }))

-- Evaluate/Run code
vim.keymap.set("n", "<leader>me", ":MoltenEvaluateOperator<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Evaluate operator" }))
vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Evaluate line" }))
vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Re-evaluate cell" }))
vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>gv", vim.tbl_extend("force", opts, { desc = "Molten: Evaluate visual" }))

-- Cell navigation
vim.keymap.set("n", "<leader>m]", ":MoltenNext<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Next cell" }))
vim.keymap.set("n", "<leader>m[", ":MoltenPrev<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Previous cell" }))

-- Output management
vim.keymap.set("n", "<leader>mo", ":MoltenShowOutput<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Show output" }))
vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Hide output" }))
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Delete cell" }))

-- Interrupt/Stop
vim.keymap.set("n", "<leader>mx", ":MoltenInterrupt<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Interrupt kernel" }))
