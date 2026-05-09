local function has_root_marker(filename, markers)
  local start = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd()
  return #vim.fs.find(markers, {
    upward = true,
    path = start,
  }) > 0
end

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = function(filename)
    if has_root_marker(filename, { "deno.json", "deno.jsonc" }) then
      return false
    end

    local start = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd()
    local roots = vim.fs.find({
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      ".git",
    }, {
      upward = true,
      path = start,
    })

    return roots[1] and vim.fs.dirname(roots[1]) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
