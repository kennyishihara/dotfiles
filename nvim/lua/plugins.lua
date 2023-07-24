local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    'projekt0n/github-nvim-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- ...
      })

      vim.cmd('colorscheme github_dark_dimmed')
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    }
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

  -- Zero LSP things
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                            -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
      end)

      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      local cmp = require('cmp')
      local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = {
          ['<Space>'] = cmp.mapping.confirm({ select = false }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
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
        },
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

  --  {
  --    'github/copilot.vim',
  --    config = function()
  --      vim.g.copilot_no_tab_map = true
  --      vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  --    end
  --  },

  {
    'codota/tabnine-nvim',
    build = "./dl_binaries.sh",
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = "<C-j>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end
  },

  -- treesitter
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('config.telescope')
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader>l', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
    end
  },

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    "cohama/lexima.vim"
  }
}

local opts = {}

require("lazy").setup(plugins, opts)
