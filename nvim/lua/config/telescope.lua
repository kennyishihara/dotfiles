vim.cmd [[
  nnoremap <leader>f         <cmd> lua require('telescope.builtin').oldfiles()<cr>
  nnoremap <leader>ff        <cmd> lua require('telescope.builtin').find_files()<cr>
  nnoremap <leader>fg        <cmd> lua require('telescope.builtin').git_files()<cr>
  nnoremap <leader>fb        <cmd> lua require('telescope.builtin').buffers()<cr>
  nnoremap <leader>fh        <cmd> lua require('telescope.builtin').help_tags()<cr>
  nnoremap <leader><leader>a <cmd> lua require('telescope.builtin').lsp_code_actions()<cr>
]]

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
