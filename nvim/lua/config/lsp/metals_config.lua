local lsp = require('config/lsp')

local metals_on_attach = function(client, bufnr)
  -- require("metals").setup_dap()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  vim.opt_global.shortmess:remove("F"):append("c")
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Space><Space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<Space>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<Space>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
  -- buf_set_keymap('n', '<Space>dc', '<cmd>lua require"dap".continue()<CR>', opts)
  -- buf_set_keymap('n', '<Space>di', '<cmd>lua require"dap".step_into()<CR>', opts)
  -- buf_set_keymap('n', '<Space>do', '<cmd>lua require"dap".step_over()<CR>', opts)
  -- buf_set_keymap('n', '<Space>dr', '<cmd>lua require"dap".repl.open()<CR>', opts)
  -- buf_set_keymap('n', '<Space>dt', '<cmd>lua require"dap".terminate()<CR>', opts)
end

local metals_config = require('metals').bare_config()

metals_config.settings = {
  showImplicitArguments = true,
}

metals_config.capabilities = lsp.capabilities

metals_config.on_attach = metals_on_attach

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
