require'telescope'.setup{
  defaults = {
    path_display = { 'smart'},
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
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}
