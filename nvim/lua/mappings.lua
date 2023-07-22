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

-- Dragging line horizontally
nnoremap(">", ">>")
nnoremap("<", "<<")

-- indent and re-select
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- Shift cells visually
nnoremap("<C-Up>", ":<C-u>move-2<CR>==", true)
xnoremap("<C-Up>", ":move-2<CR>gv=gv", true)
nnoremap("<C-Down>", ":<C-u>move+<CR>==", true)
xnoremap("<C-Down>", ":move'>+<CR>gv=gv", true)

-- Universal get me back to Normal mode
-- tnoremap <esc> <c-\><c-n>

-- Save file Space+w
nnoremap("<Leader>w", ":w<CR>")

-- Automatically jump to end of text you pasted
vnoremap("y", "y`]", true)
vnoremap("p", "p`]", true)
nnoremap("p", "p`]", true)

-- delete without yanking
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- replace currently selected text with default register without yanking it
vnoremap("<leader>p", '"_dP')

-- Move between vim windows
-- nnoremap("<C-h>", "<C-W>h")
-- nnoremap("<C-j>", "<C-W>j")
-- nnoremap("<C-k>", "<C-W>k")
-- nnoremap("<C-l>", "<C-W>l")
