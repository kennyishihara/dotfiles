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
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup({
                theme = "Kanagawa (Gogh)"
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
            vim.api.nvim_set_keymap("n", "<F2>", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
        end
    },

    {
        'stevearc/dressing.nvim',
        opts = {}
    },

    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            vim.g.nvim_tree_indent_markers = 1
            vim.g.nvim_tree_highlight_opened_files = 1
            require('nvim-tree').setup {
                trash = {
                    cmd = "trash"
                }
            }
            vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
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
        branch = 'v3.x',
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

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Enter>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<C-p>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item(cmp_select_opts)
                        else
                            cmp.complete()
                        end
                    end),
                    ['<C-n>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item(cmp_select_opts)
                        else
                            cmp.complete()
                        end
                    end),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = {
                        max_height = 15,
                        max_width = 60,
                    }
                },
                formatting = {
                    fields = { 'abbr', 'menu', 'kind' },
                    format = function(entry, item)
                        local short_name = {
                            nvim_lsp = 'LSP',
                            nvim_lua = 'nvim'
                        }

                        local menu_name = short_name[entry.source.name] or entry.source.name

                        item.menu = string.format('[%s]', menu_name)
                        return item
                    end,
                },
            })
        end
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
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#7CD0A7" })
            require('copilot').setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<F5>",
                        prev = "<F6>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {},
            })
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim',
        },
        config = function()
            require('config.telescope')
        end
    },

    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require('mini.align').setup()
            require('mini.pairs').setup()
            require('mini.surround').setup()
            require('mini.move').setup()
            require('mini.comment').setup()
            require('mini.splitjoin').setup()
            require('mini.indentscope').setup()
        end
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = false,
        ft = "markdown",
        keys = {
            { "<leader>on", "<cmd>ObsidianNew<cr>",         desc = "New Obsidian note",               mode = "n" },
            { "<leader>oo", "<cmd>ObsidianSearch<cr>",      desc = "Search Obsidian notes",           mode = "n" },
            { "<leader>ot", "<cmd>ObsidianTags<cr>",        desc = "Search tags",                     mode = "n" },
            { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch",                    mode = "n" },
            { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",   desc = "Show location list of backlinks", mode = "n" },
            { "<leader>of", "<cmd>ObsidianFollowLink<cr>",  desc = "Follow link under cursor",        mode = "n" },
        },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/Obsidian/personal",
                },
            },
            daily_notes = {
                folder = "notes/dailies",
                date_format = "%d-%m-%Y",
            }
        },
        config = true
    },

    {
        "lervag/vimtex",
        lazy = false,
        config = function()
            vim.g.vimtex_view_method = 'sioyek'
        end
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
