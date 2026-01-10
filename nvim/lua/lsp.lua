vim.o.completeopt = "menu,menuone,noselect"

local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

  vim.keymap.set("i", "<C-n>", "<C-x><C-o>", {
    buffer = bufnr,
    desc = "Trigger LSP completion",
  })
end

local servers = {}
local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"

for _, file in ipairs(vim.fn.globpath(lsp_dir, "*.lua", false, true)) do
  local name = file:match("([^/]+)%.lua$")
  if name and name ~= "lsp" then
    local ok, cfg = pcall(require, "lsp." .. name)
    if ok and type(cfg) == "table" then
      servers[name] = cfg
    end
  end
end

local function resolve_root(bufnr, cfg)
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if cfg.root_dir and type(cfg.root_dir) == "function" then
    return cfg.root_dir(filename) or vim.fn.getcwd()
  end

  if cfg.root_markers then
    local paths = vim.fs.find(cfg.root_markers, {
      upward = true,
      path = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd(),
    })
    if #paths > 0 then
      return vim.fs.dirname(paths[1])
    end
  end

  return vim.fn.getcwd()
end

local function start_for_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype
  if not ft or ft == "" then
    return
  end

  for name, cfg in pairs(servers) do
    if not cfg.filetypes or vim.tbl_contains(cfg.filetypes, ft) then
      local root_dir = resolve_root(bufnr, cfg)

      for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
        if client.config.root_dir == root_dir then
          if not client.attached_buffers[bufnr] then
            vim.lsp.buf_attach_client(bufnr, client.id)
          end
          return
        end
      end

      local new_cfg = vim.tbl_deep_extend("force", cfg, {
        name = name,
        root_dir = root_dir,
        on_attach = on_attach,
      })

      vim.lsp.start(new_cfg)
      return
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    start_for_buffer(args.buf)
  end,
})

return {
  on_attach = on_attach,
  start_for_buffer = start_for_buffer,
}
