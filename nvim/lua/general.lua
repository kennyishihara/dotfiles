vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.syntax = "on"
vim.opt.autoindent = true
vim.opt.shiftround = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.re = 2
vim.opt.encoding = "UTF-8"
vim.opt.clipboard = "unnamed"
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.completeopt= "menuone,noinsert,noselect"
vim.opt.shortmess:append("c")
vim.opt.diffopt:append("iwhite")
vim.opt.showmatch = true
vim.opt.wrap = false
vim.o.termguicolors = false

-- For md files, use conceal to hide the markdown syntax
vim.opt.conceallevel = 0
