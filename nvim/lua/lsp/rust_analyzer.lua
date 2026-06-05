-- lua/lsp/rust_analyzer.lua
local function is_rustup_sysroot_source(filename)
  local path = vim.fs.normalize(filename)
  local rustup_home = vim.fs.normalize(vim.env.RUSTUP_HOME or (vim.env.HOME .. "/.rustup"))

  return path:sub(1, #rustup_home) == rustup_home
    and path:find("/toolchains/[^/]+/lib/rustlib/src/rust/", 1) ~= nil
end

return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = function(filename)
    if is_rustup_sysroot_source(filename) then
      return false
    end

    local start = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd()
    local roots = vim.fs.find({
      'Cargo.toml',
      'rust-project.json',
      '.git'
    }, {
      upward = true,
      path = start,
    })

    return roots[1] and vim.fs.dirname(roots[1]) or vim.fn.getcwd()
  end,
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
