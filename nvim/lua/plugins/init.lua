local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- [Plugins]
    -- LSP
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'jay-babu/mason-nvim-dap.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'neovim/nvim-lspconfig' },
    {
        'nvimtools/none-ls.nvim',
        event = 'BufRead', -- !!
        dependencies = "gbprod/none-ls-shellcheck.nvim",
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        'LhKipp/nvim-nu',
        config = function()
            require 'plugins.config.nu'
        end
    },
    {
        'R-nvim/R.nvim',
        ft = { 'qmd', 'rmd' },
    },
    --[[ {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
    }, ]]
    {
        'mfussenegger/nvim-jdtls',
        dependencies = "mfussenegger/nvim-dap",
        ft = "java",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    require("jdtls").start_or_attach(require("plugins.config.jdtls").config)
                end,
            })
        end
    },
    -- CMP (blink.cmp - faster alternative to nvim-cmp)
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.*',
        opts = {},
        config = function()
            require 'plugins.config.blink'
        end
    },
    {
        dir = '/home/user/plugin/kattis.nvim/misc/competitest.nvim',
        name = 'competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        lazy = false,
        --[[ config = function()
            require('competitest').setup({
                submit = {
                    kattis = {
                        config_file = vim.fn.expand('~/.kattisrc'),
                    },
                },
            })
        end ]]
        config = function()
            require 'plugins.config.competitest'
        end
    },
    -- Debugger
    { 'mfussenegger/nvim-dap' },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { "<Space>du", "<CMD>lua require('dapui').toggle()<CR>" },
        },
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require 'core.debugger'
        end
    },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'folke/neodev.nvim' },
    { 'mfussenegger/nvim-dap-python' },
    -- Jupyter/Notebook Integration
    {
        'benlubas/molten-nvim',
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        ft = { "python", "markdown", "quarto", "json" },
        config = function()
            require 'plugins.config.molten'
        end
    },
    {
        '3rd/image.nvim',
        ft = { "python", "markdown", "quarto" },
        config = function()
            require 'plugins.config.image'
        end
    },
    {
        'quarto-dev/quarto-nvim',
        ft = { "quarto", "markdown" },
        dependencies = {
            'jmbuhr/otter.nvim',
        },
    },
    {
        'goerz/jupytext.nvim',
        version = '0.2.0',
        -- ft = { "python", "markdown" },
        opts = {},
        lazy = false
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = 'BufRead',
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "zyllus17/flutter-snippets"
        }
    },
    -- Extended functionality
    -- Plenary (required by many plugins)
    { 'nvim-lua/plenary.nvim', lazy = false },
    -- Snacks.nvim (faster alternative to telescope)
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require 'plugins.config.snacks'
        end
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            -- { "<leader>a",  nil,                              desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            -- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            { "<leader>ao", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            -- { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            -- { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
            -- { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
        },
    },
    {
        'folke/zen-mode.nvim',
        keys = {
            { "<leader>z", "<CMD>ZenMode<CR>" },
        },
        config = function()
            require 'plugins.config.zen-mode'
        end
    },
    -- Noice.nvim (better cmdline and error experience)
    {
        'folke/noice.nvim',
        event = "VeryLazy",
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        config = function()
            require 'plugins.config.noice'
        end
    },
    {
        'subnut/nvim-ghost.nvim',
        cmd = "GhostStart"
    },
    {
        'stevearc/dressing.nvim',
        event = 'BufRead',
    },
    {
        'kevinhwang91/nvim-ufo',
        keys = {
            { "<C-f>", "<CMD>lua require 'plugins.config.nvim-ufo'<CR>" },
        },
        dependencies = 'kevinhwang91/promise-async'
    },
    {
        'mbbill/undotree',
        keys = {
            { "<C-u>", "<CMD>UndotreeToggle<CR>" },
        },
    },
    {
        'preservim/tagbar',
        keys = {
            { "<C-t>", ":Tagbar<CR>" },
        },
    },
    { 'fidian/hexmode' },
    { 'mattn/emmet-vim' },
    -- { 'luk400/vim-jukit' },
    -- Enhancements
    {
        "sindrets/diffview.nvim",
        event = "BufRead"
    },
    {
        "hat0uma/csvview.nvim",
        -- ft = "csv",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            -- recommended settings
            default = {
                embed_image_as_base64 = false,
                prompt_for_file_name = false,
                drag_and_drop = {
                    insert_mode = false,
                },
                -- required for Windows users
                use_absolute_path = true,
            },
        },
        keys = {
            { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
    },
    { 'jbyuki/nabla.nvim' },
    {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
    {
        'famiu/bufdelete.nvim',
        event = { "BufRead", "BufAdd" },
    },
    {
        'Shatur/neovim-session-manager',
        lazy = false,
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require 'plugins.config.session-manager'
        end
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require 'plugins.config.comment'
        end
    },
    {
        'Raimondi/delimitMate',
        event = { "BufRead", "BufAdd" },
    },
    {
        'phaazon/hop.nvim',
        keys = {
            { "S", "<CMD>HopWord<CR>" },
        },
        config = true
    },
    {
        event = { "BufRead", "BufAdd" },
        'svermeulen/vim-cutlass'
    },
    {
        'airblade/vim-rooter',
        config = function()
            require 'plugins.config.rooter'
        end
    },
    {
        'nacro90/numb.nvim',
        config = true
    },
    {
        'rickhowe/diffchar.vim',
        event = { "BufRead", "BufAdd" },
    }, -- Better diff mode
    {
        'tpope/vim-surround',
        event = { "BufRead", "BufAdd" },
    },
    -- Interface
    {
        'kyazdani42/nvim-tree.lua',
        keys = {
            { "<leader>e", "<CMD>NvimTreeToggle<CR>" },
        },
        config = function()
            require 'plugins.config.nvim-tree'
        end
    },
    {
        'akinsho/bufferline.nvim',
        event = { "BufRead", "BufAdd" },
        config = function()
            require 'plugins.config.bufferline'
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        event = { "BufRead", "BufAdd" },
        -- dependencies = "Exafunction/codeium.vim",
        config = function()
            require 'plugins.config.lualine'
        end
    },
    -- Aesthetics
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            require 'plugins.config.grubvox-material'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require 'plugins.config.treesitter'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- event = 'BufReadPost',
        config = function()
            require 'plugins.config.nvim-treesitter-textobjects'
        end
    },
    {
        'brenoprata10/nvim-highlight-colors',
        event = { "BufRead", "BufAdd" },
        config = function()
            require 'plugins.config.nvim-highlight-colors'
        end
    },
    {
        'yuuhikaze/plantuml-syntax',
        ft = { 'puml', 'plantuml', 'uml', 'iuml' },
        config = function()
            vim.cmd(
                [[autocmd BufRead,BufNewFile * if !did_filetype() && getline(1) =~# '@startuml\>'| setfiletype plantuml | endif]])
            vim.cmd([[autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml,*.iuml set filetype=plantuml]])
        end
    },
    {
        'mtdl9/vim-log-highlighting',
        ft = 'log'
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require 'plugins.config.nvim-web-devicons'
        end
    },
}, {
    -- [Options]
    install = {
        colorscheme = { "gruvbox-material", "retrobox" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    ui = {
        backdrop = 100
    },
    defaults = {
        lazy = true
    }
})
