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
        'catppuccin/nvim',
        priority = 1000,
        name = 'catppuccin',
        config = function()
            vim.cmd("colorscheme catppuccin-mocha")
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup({
                theme = "Kanagawa (Gogh)",
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
        'folke/trouble.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('trouble').setup {
                diagnostic_signs = true,
            }
            vim.api.nvim_set_keymap("n", "<F1>", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
            vim.api.nvim_set_keymap("n", "<F5>", "<cmd>Trouble symbols toggle focus=false<cr>", { silent = true, noremap = true })
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

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'williamboman/mason.nvim' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            require("mason").setup({
                lazy = false,
                config = true
            })
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },

    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
                virtual_text = {
                    enabled = true,
                    key_bindings = {
                        accept = "<C-l>",
                        accept_word = false,
                        accept_line = false,
                        clear = "<C-x>",
                        next = "<C-j>",
                        prev = "<C-k>"
                    }
                }
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
            require('mini.completion').setup()
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
