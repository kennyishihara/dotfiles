vim.o.completeopt = 'menuone,noselect,popup'

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local buffer = ev.buf
        local opts = { buffer = buffer, noremap = true, silent = true }
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    end,
})

local lsp_path = "lsp"
local servers = {}

local function find_root_dir(bufnr, root_markers)
    bufnr = bufnr or 0
    if not root_markers or #root_markers == 0 then
        return vim.fn.getcwd()
    end

    if vim.fs.root then
        return vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    else
        local buffer_path = vim.api.nvim_buf_get_name(bufnr)
        local current_dir = vim.fn.fnamemodify(buffer_path, ':p:h')

        local paths = vim.fs.find(root_markers, {
            upward = true,
            path = current_dir,
        })

        if paths and #paths > 0 then
            return vim.fs.dirname(paths[1])
        end

        return vim.fn.getcwd()
    end
end

local function load_lsp_configs()
    local lsp_dir = vim.fn.stdpath("config") .. "/lua/" .. lsp_path
    local lsp_files = vim.fn.globpath(lsp_dir, "*.lua", false, true)

    for _, file in ipairs(lsp_files) do
        local server_name = file:match("([^/]+)%.lua$")
        if server_name then
            local ok, config = pcall(require, lsp_path .. "." .. server_name)
            if ok and type(config) == "table" then
                local original_on_attach = config.on_attach
                config.on_attach = function(client, bufnr)
                    if original_on_attach then
                        original_on_attach(client, bufnr)
                    end

                    vim.lsp.completion.enable(true, client.id, bufnr, {
                        autotrigger = true,
                        convert = function(item)
                            return { abbr = item.label:gsub('%b()', '') }
                        end,
                    })
                end

                servers[server_name] = config
                servers[server_name].name = server_name
            else
                print("Failed to load LSP config for: " .. server_name)
            end
        end
    end
end

load_lsp_configs()

local function start_lsp_for_buffer(bufnr, filetype)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    filetype = filetype or vim.bo[bufnr].filetype

    for server_name, config in pairs(servers) do
        if config.filetypes and vim.tbl_contains(config.filetypes, filetype) then
            local root_dir
            if config.root_markers then
                root_dir = find_root_dir(bufnr, config.root_markers)
            elseif config.root_dir and type(config.root_dir) == "function" then
                root_dir = config.root_dir(vim.api.nvim_buf_get_name(bufnr))
            else
                root_dir = config.root_dir or vim.fn.getcwd()
            end

            local matching_clients = vim.lsp.get_clients({
                name = server_name,
                bufnr = bufnr
            })

            local client_for_root = nil
            for _, client in ipairs(matching_clients) do
                if client.config.root_dir == root_dir then
                    client_for_root = client
                    break
                end
            end

            if client_for_root then
                if not client_for_root.attached_buffers[bufnr] then
                    vim.lsp.buf_attach_client(bufnr, client_for_root.id)
                end
            else
                local client_config = vim.deepcopy(config)
                client_config.root_dir = root_dir
                local client_id = vim.lsp.start(client_config)
                if not client_id then
                    print("Failed to start LSP client for: " .. server_name)
                end
            end

            break
        end
    end
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        start_lsp_for_buffer(args.buf, args.match)
    end,
})

return {
    start_lsp_for_buffer = start_lsp_for_buffer,
}
