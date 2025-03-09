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

    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    -- this is the "custom handler" for `lua_ls`
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
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
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        adapter = "lmstudio"
                    },
                    inline = {
                        adapter = "lmstudio"
                    },
                    agent = {
                        adapter = "lmstudio"
                    }
                },
                adapters = {
                    lmstudio = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            env = {
                                url = "http://localhost:11434",    -- optional: default value is ollama url http://127.0.0.1:11434
                                chat_url = "/v1/chat/completions", -- optional: default value, override if different
                            },
                            schema = {
                                model = {
                                    default = "deepseek-coder-v2-lite-instruct-mlx", -- define llm model to be used
                                },
                            },
                        })
                    end,
                    opts = {
                        show_defaults = false
                    },
                },
            })
            vim.api.nvim_set_keymap('n', '<leader>aa', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true })
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
            require('mini.indentscope').setup()
            require('mini.jump').setup()
            require('mini.files').setup()
            require('mini.completion').setup()
            require('mini.icons').setup()
            require('mini.git').setup()
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
