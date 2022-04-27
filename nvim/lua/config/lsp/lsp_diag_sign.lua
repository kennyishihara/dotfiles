-- set lsp diagnostic sign: neovim 0.6.1
vim.fn.sign_define(
  'DiagnosticSignError',
  {text = '', texthl = "DiagnosticDefaultError"}
)
vim.fn.sign_define(
  'DiagnosticSignWarn',
  {text = '', texthl = 'DiagnosticSignWarn'}
)
vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = '', texthl = 'DiagnosticSignInfo' }
)
vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '', texthl = 'DiagnosticSignHint' }
)
