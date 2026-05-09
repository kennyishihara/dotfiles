return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
  single_file_support = true,
  init_options = {
    provideFormatter = true,
  },
}
