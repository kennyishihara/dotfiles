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

local plugins = {
    {
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup({
                dim_inactive_windows = false,
                extend_background_behind_borders = true,
                enable = {
                    terminal = true,
                    migrations = true, -- Handle deprecated options automatically
                },
                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },
            })
            vim.cmd("colorscheme rose-pine")
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = "ayu_dark",
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            path = 3
                        },
                    }
                }
            })
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require("config.treesitter")
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("config.gitsigns")
        end
    },

    -- Mason for LSP server management
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = function()
            require("mason").setup()
        end
    },

    -- Mason-lspconfig for easy installation of language servers
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {},
            })
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            require('config.telescope')
        end
    },

    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        dependencies = {
            -- check the installation instructions at
            -- https://github.com/folke/snacks.nvim
            "folke/snacks.nvim"
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>t",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>wt",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
        },
        -- 👇 if you use `open_for_directories=true`, this is recommended
        init = function()
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            -- vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },

    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require('mini.ai').setup()
            require('mini.align').setup()
            require('mini.pairs').setup()
            require('mini.surround').setup()
            require('mini.comment').setup()
            require('mini.splitjoin').setup()
            -- require('mini.files').setup()
            require('mini.icons').setup()
            require('mini.snippets').setup()
            -- vim.keymap.set("n", "<leader>t", function()
            --     if not require("mini.files").close() then
            --         -- If it wasn't open, then open it
            --         require("mini.files").open()
            --     end
            -- end, { desc = "Toggle mini.files explorer" })
        end
    },

    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').setup({})
            vim.keymap.set({ 'n', 'x', 'o' }, 'z', '<Plug>(leap-forward)')
            vim.keymap.set({ 'n', 'x', 'o' }, 'Z', '<Plug>(leap-backward)')
            vim.keymap.set({ 'n', 'x', 'o' }, 'zs', '<Plug>(leap-from-window)')
        end
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    hide_during_completion = true,
                    debounce = 75,
                    trigger_on_accept = true,
                    keymap = {
                        accept = "<C-l>",
                        next = "<C-j>",
                        prev = "<C-k>",
                        dismiss = "<C-;>",
                    },
                },
                copilot_model = "gpt-4o-copilot",
            })
        end,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
