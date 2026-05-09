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
  root_markers = { "deno.json", "deno.jsonc" },
  single_file_support = false,
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
