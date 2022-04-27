vim.diagnostic.config({ virtual_text = false })

require('trld').setup {
  -- where to render the diagnostics. 'top' | 'bottom'
  position = 'top',

  -- if this plugin should execute it's builtin auto commands
  auto_cmds = true,

  -- diagnostics highlight group names
  highlights = {
      error = "DiagnosticFloatingError",
      warn =  "DiagnosticFloatingWarn",
      info =  "DiagnosticFloatingInfo",
      hint =  "DiagnosticFloatingHint",
  },

  -- diagnostics formatter. must return
  -- {
  --   { "String", "Highlight Group Name"},
  --   { "String", "Highlight Group Name"},
  --   { "String", "Highlight Group Name"},
  --   ...
  -- }
  formatter = function(diag)
      local u = require 'trld.utils'

      local msg = diag.message
      local src = diag.source
      local code = tostring(diag.user_data.lsp.code)

      -- remove dots
      msg = msg:gsub('%.', '')
      src = src:gsub('%.', '')
      code = code:gsub('%.', '')

      -- remove starting and trailing spaces
      msg = msg:gsub('[ \t]+%f[\r\n%z]', '')
      src = src:gsub('[ \t]+%f[\r\n%z]', '')
      code = code:gsub('[ \t]+%f[\r\n%z]', '')

      return {
          {msg, u.get_hl_by_serverity(diag.severity)},
          {' ', ""},
          {code, "Comment"},
          {' ', ""},
          {src, "Folded"},
      }
  end,
}
