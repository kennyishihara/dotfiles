vim.g.nvim_tree_respect_buf_cwd = 1
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true})

-- update cwd based on nvim tree path
require("nvim-tree").setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  filters = {
    dotfiles = true,
  }
})
