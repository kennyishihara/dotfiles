local nnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true })
end

local vnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true, silent = silent })
end

local xnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("x", lhs, rhs, { noremap = true, silent = silent })
end

-- resizing
nnoremap("=", "<C-w>+")
nnoremap("-", "<C-w>-")
nnoremap("_", "<C-w><")
nnoremap("+", "<C-w>>")

-- jump between buffers
nnoremap("<Space><Tab>", ":b#<CR>")

-- Automatically jump to end of text you pasted
vnoremap("y", "y`]", true)
vnoremap("p", "p`]", true)
nnoremap("p", "p`]", true)

-- delete without yanking
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- replace currently selected text with default register without yanking it
vnoremap("<leader>p", '"_dP')
