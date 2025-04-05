local builtin = require('telescope.builtin')
vim.keymap.set('n', '<F1>', builtin.find_files, {})
vim.keymap.set('n', '<F2>', builtin.buffers, {})
vim.keymap.set('n', '<F3>', builtin.live_grep, {})


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
