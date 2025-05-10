return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".json", ".git" },
  single_file_support = true,
  init_options = {
    provideFormatter = true
  }
}
