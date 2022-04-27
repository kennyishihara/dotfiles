-- https://github.com/ViRu-ThE-ViRuS/configs/blob/master/nvim/lua/plug-config/dap.lua
-- servers launched internally in neovim

local dap = require('dap')

local function lua_systemlist(cmd)
    local stdout, rc = {}, 0
    local handle = io.popen(cmd .. ' 2>&1 ; echo $?', 'r')

    if handle then
        for line in handle:lines() do stdout[#stdout + 1] = line end
        rc = tonumber(stdout[#stdout])
        stdout[#stdout] = nil
    end

    handle:close()
    return stdout, rc
end

local function lua_system(cmd)
    local stdout, rc = lua_systemlist(cmd)
    if next(stdout) == nil then return nil, rc end
    return table.concat(stdout, '\n'), rc
end

local function get_python()
    local python, _ = lua_system('which python3')
    return python
end

-- adapters
dap.adapters.python = {
    type = 'executable',
    command = 'python3',
    args = {'-m', 'debugpy.adapter'}
}

dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        program = '${file}',
        terminal = 'integrated',
        console = 'integratedTerminal',
        pythonPath = get_python()
    }
}

dap.configurations.c = {
    {
        type = "codelldb",
        request = "launch",
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        stopOnEntry = false,
        program = function()
            return vim.fn.input('executable: ', vim.fn.getcwd() .. '/', 'file')
        end
    }
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.cpp

-- repl setup
dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
    exit = {'q', 'exit'},
    custom_commands = {
        ['.run_to_cursor'] = dap.run_to_cursor,
        ['.restart'] = dap.run_last
    }
})
