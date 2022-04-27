local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}

  -- nvim schemes
  use { 'folke/tokyonight.nvim' }
  use { "rebelot/kanagawa.nvim" }
  use { 'EdenEast/nightfox.nvim'}

  use {'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- utils
  use {'kyazdani42/nvim-tree.lua',
    config = function()
      require("config.nvim-tree")
    end
  }
  use {"ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }
  use { 'lukas-reineke/indent-blankline.nvim'}
  use { 'scrooloose/nerdcommenter',
    config = function()
      require("config.nerdcommenter")
    end
  }
  use {'windwp/nvim-autopairs',
    config = function()
      require('config.autopairs')
    end
  }
  use {'junegunn/fzf', run = ":call fzf#install()"}
  use {'junegunn/vim-easy-align',
    config = vim.cmd [[
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)
    ]]
  }
  use { 'simrat39/symbols-outline.nvim',
    config = function()
      require("config.symbols-outline")
    end
  }
  use { 'ggandor/lightspeed.nvim',
    config = function()
      require("config.lightspeed")
    end
  }
  use {'andymass/vim-matchup'}
  use {'terryma/vim-expand-region',
    config = vim.cmd [[
      vmap v <Plug>(expand_region_expand)
      vmap <C-v> <Plug>(expand_region_shrink)
    ]]
  }
  use {'rhysd/conflict-marker.vim'}
  use { 'akinsho/toggleterm.nvim',
    config=function ()
      require('toggleterm').setup{
        open_mapping = [[<C-\>]],
        direction = 'float',
        float_opts = {
          border = 'curved',
        }
      }
    end
  }
  use { 'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        use_diagnostic_signs = true,
        auto_close = true,
      }
      vim.api.nvim_set_keymap("n", "<F2>", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
      end
  }
  use { "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup{
        mapping = {"jk", "kj"},
        clear_empty_lines = false,
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      }
    end,
  }
  use {'stevearc/dressing.nvim'}
  use { 'nvim-treesitter/nvim-treesitter',
    config = function()
      require("config.treesitter")
    end
  }


  -- Git
  use { 'tpope/vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require("config.gitsigns")
    end
  }

  -- lsp
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer',
    config = function()
      require("config/lsp/lsp_installer")
    end
  }
  use { 'ray-x/lsp_signature.nvim',
    config = function()
      require("config.lsp_signature")
    end
  }
  use { 'scalameta/nvim-metals',
    config = function()
      require('config/lsp/metals_config')
    end,
    requires = {
      "nvim-lua/plenary.nvim"
    }
  }


  -- cmp / lspkind
  use {'onsails/lspkind.nvim'}
  use {'github/copilot.vim',
    config = function()
      vim.cmd[[
        imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
        let g:copilot_no_tab_map = v:true
      ]]
    end
  }
  use { 'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
        };
        default = true;
      }
    end
  }

  use {'Mofiqul/trld.nvim',
    config = function()
      require("config.trld")
    end
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('config.cmp')
    end
  }


  -- dap
  use { 'mfussenegger/nvim-dap',
      config = function()
        require("config.dap")
      end
  }
  use { 'rcarriga/nvim-dap-ui',
    config = function()
      require("config/dapui")
    end
  }

  -- telescope
  use {'nvim-lua/plenary.nvim'}
  use { 'nvim-telescope/telescope.nvim',
    config = function()
      require("config.telescope")
    end
  }
  use { "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

end)
