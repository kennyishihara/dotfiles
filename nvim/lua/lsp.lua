vim.o.completeopt = 'menuone,noselect,popup'

-- Helper function to find project root directory
local function find_root_dir(bufnr, root_markers)
    bufnr = bufnr or 0
    if not root_markers or #root_markers == 0 then
        return vim.fn.getcwd()
    end

    if vim.fs.root then
        return vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    else
        -- Fallback for older versions
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

-- LSP attach configuration
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local buffer = ev.buf
        local opts = { buffer = buffer, noremap = true, silent = true }

        -- Key mappings
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('i', '<C-n>', '<C-x><C-o>', { buffer = buffer, desc = 'Trigger LSP completion' })

        -- Enable built-in completion if available
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and vim.lsp.completion then
            vim.lsp.completion.enable(true, client.id, buffer, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub('%b()', '') }
                end,
            })
        end
    end,
})

-- Load LSP configurations from lua/lsp/ directory
local servers = {}
local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"
local lsp_files = vim.fn.globpath(lsp_dir, "*.lua", false, true)

for _, file in ipairs(lsp_files) do
    local server_name = file:match("([^/]+)%.lua$")
    if server_name then
        local ok, config = pcall(require, "lsp." .. server_name)
        if ok and type(config) == "table" then
            servers[server_name] = config
        end
    end
end

-- Start LSP for buffer
local function start_lsp_for_buffer(bufnr, filetype)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    filetype = filetype or vim.bo[bufnr].filetype

    for server_name, config in pairs(servers) do
        if config.filetypes and vim.tbl_contains(config.filetypes, filetype) then
            -- Find proper root directory
            local root_dir = find_root_dir(bufnr, config.root_markers) or vim.fn.getcwd()

            -- Check for existing client with same root
            local existing_client = nil
            for _, client in ipairs(vim.lsp.get_clients({ name = server_name })) do
                if client.config.root_dir == root_dir then
                    existing_client = client
                    break
                end
            end

            if existing_client then
                if not existing_client.attached_buffers[bufnr] then
                    vim.lsp.buf_attach_client(bufnr, existing_client.id)
                end
            else
                -- Start new LSP client
                local client_config = vim.deepcopy(config)
                client_config.root_dir = root_dir
                vim.lsp.start(client_config)
            end
            break
        end
    end
end

-- Auto-start LSP on FileType
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        start_lsp_for_buffer(args.buf, args.match)
    end,
})

return {
    start_lsp_for_buffer = start_lsp_for_buffer,
}
