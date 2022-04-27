-- Lists stuff while typing

local cmp = require('cmp')
local lspkind = require('lspkind')

-- nvim-cmp setup
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      before = function (entry, vim_item)

        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          nvim_lua = "[Lua]",
        })[entry.source.name]

        return vim_item
      end
    })
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-c>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    {'i', 's',}
    ),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
    { name = "calc" },
    { name = "vsnip" }
  },
}
