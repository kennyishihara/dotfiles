-- lua/lsp/pylsp.lua
return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git"
  },
  single_file_support = true,
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        autopep8 = { enabled = true },
        pyflakes = { enabled = true },
        pycodestyle = { enabled = true },
        pyls_isort = { enabled = true },
        pyls_mypy = { enabled = true },
      }
    }
  }
}
