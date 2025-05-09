vim.o.completeopt = 'menuone,noselect,popup'
vim.o.updatetime = 200

local user_group = vim.api.nvim_create_augroup('UserLspConfig', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = user_group,
  callback = function(ev)
    local buf = ev.buf
    local opts = { buffer = buf, noremap = true, silent = true }

    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    vim.api.nvim_create_autocmd({'TextChangedI','CursorHoldI'}, {
      group = vim.api.nvim_create_augroup('LspAutoPopup_'..buf, { clear = true }),
      buffer = buf,
      callback = function()
        local keys = vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'i', true)
      end,
    })
  end,
})

local lsp_path = 'lsp'
local servers = {}
local config_dir = vim.fn.stdpath('config') .. '/lua/' .. lsp_path
for _, file in ipairs(vim.fn.globpath(config_dir, '*.lua', false, true)) do
  local name = file:match('([^/]+)%.lua$')
  if name then
    local ok, cfg = pcall(require, lsp_path .. '.' .. name)
    if ok and type(cfg) == 'table' then
      cfg.name = name
      servers[name] = cfg
    else
      vim.notify('Failed to load LSP config for: ' .. name, vim.log.levels.WARN)
    end
  end
end

local function start_lsp_for_buffer(bufnr, ft)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  ft = ft or vim.bo[bufnr].filetype
  for _, cfg in pairs(servers) do
    if cfg.filetypes and vim.tbl_contains(cfg.filetypes, ft) then
      local clients = vim.lsp.get_clients({ name = cfg.name })
      if #clients == 0 then
        cfg.root_dir = cfg.root_dir or vim.fn.getcwd()
        vim.lsp.start(cfg)
      else
        for _, client in ipairs(clients) do
          if not client.attached_buffers[bufnr] then
            vim.lsp.buf_attach_client(bufnr, client.id)
          end
        end
      end
      break
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    start_lsp_for_buffer(args.buf, args.match)
  end,
})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})
