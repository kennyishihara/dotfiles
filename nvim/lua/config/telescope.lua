local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>l', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>u', "<cmd>Telescope undo<cr>")


require 'telescope'.setup({
  defaults = {
    path_display = { 'smart' },
    mappings = {
      i = {
        ['<C-j>']   = 'move_selection_next',
        ['<Tab>']   = 'move_selection_next',
        ['<C-k>']   = 'move_selection_previous',
        ['<S-Tab>'] = 'move_selection_previous',
      }
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-d>'] = "delete_buffer",
        }
      }
    }
  },
  extensions = {
      undo = {},
  }
})

require 'telescope'.load_extension('undo')
