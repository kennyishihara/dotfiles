-- lua/lsp/deno.lua
-- Basic Deno LSP config for Neovim
return {
  cmd = { "deno", "lsp" },
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "javascript.jsx"
  },
  -- Typical root markers for Deno or JS/TS projects.
  -- Feel free to adjust (or remove root_dir if you have a more global config).
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern("deno.json", "deno.jsonc", "package.json", ".git")(fname)
      or util.path.dirname(fname)
  end,
  init_options = {
    lint = true,
    unstable = false, -- set to true if you need Deno's unstable APIs
  },
  settings = {
    deno = {
      enable = true,
      lint = true,
      unstable = false
    }
  }
}
