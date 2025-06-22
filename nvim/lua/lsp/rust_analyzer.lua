-- lua/lsp/rust_analyzer.lua
return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = {
    'Cargo.toml',
    'rust-project.json',
    '.git'
  },
  single_file_support = true,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true
      },
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true
      }
    }
  }
}
