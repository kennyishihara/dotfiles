
-- lua/config/lsp.lua

-- Global mappings for diagnostics
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to set up mappings once a server attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local buffer = ev.buf
    local opts = { buffer = buffer, noremap = true, silent = true }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Dynamically load LSP configurations from the `lsp/` folder
local lsp_path = "lsp"
local servers = {}

-- Iterate through all files in the `lsp/` folder and load their configurations
local function load_lsp_configs()
  local lsp_dir = vim.fn.stdpath("config") .. "/lua/" .. lsp_path
  local lsp_files = vim.fn.globpath(lsp_dir, "*.lua", false, true)

  for _, file in ipairs(lsp_files) do
    local server_name = file:match("([^/]+)%.lua$")
    if server_name then
      local ok, config = pcall(require, lsp_path .. "." .. server_name)
      if ok and type(config) == "table" then
        servers[server_name] = config
        servers[server_name].name = server_name -- Ensure the name field is set
      else
        print("Failed to load LSP config for: " .. server_name)
      end
    end
  end
end

load_lsp_configs()

-- Handle file type detection and LSP startup
local function start_lsp_for_buffer(bufnr, filetype)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  filetype = filetype or vim.bo[bufnr].filetype

  -- Map filetypes to LSP server names dynamically based on loaded configs
  for server_name, config in pairs(servers) do
    if config.filetypes and vim.tbl_contains(config.filetypes, filetype) then
      -- Check if the server is already running for this buffer
      local matching_clients = vim.lsp.get_clients({ name = server_name })
      if #matching_clients > 0 then
        -- Attach existing client to the buffer if not already attached
        for _, client in ipairs(matching_clients) do
          if not client.attached_buffers[bufnr] then
            vim.lsp.buf_attach_client(bufnr, client.id)
          end
        end
      else
        -- Start a new client for this buffer's configuration and root directory.
        local root_dir = config.root_dir or vim.fn.getcwd()
        config.root_dir = root_dir -- Ensure root_dir is set before starting the server.
        local client_id = vim.lsp.start(config)
        if not client_id then
          print("Failed to start LSP client for: " .. server_name)
        end
      end

      break -- Stop searching once we find a matching server.
    end
  end
end

-- Autocommands to trigger LSP startup for specific file types.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    start_lsp_for_buffer(args.buf, args.match)
  end,
})

return {
  start_lsp_for_buffer = start_lsp_for_buffer,
}
