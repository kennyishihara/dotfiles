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
        "olimorris/onedarkpro.nvim",
        config = function()
            vim.cmd("colorscheme onedark_dark")
        end
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
            require('mini.jump').setup()
            require('mini.files').setup()
            require('mini.icons').setup()
            require('mini.snippets').setup()
            vim.keymap.set("n", "<leader>t", function()
                if not require("mini.files").close() then
                    -- If it wasn't open, then open it
                    require("mini.files").open()
                end
            end, { desc = "Toggle mini.files explorer" })
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
}

local opts = {}

require("lazy").setup(plugins, opts)
