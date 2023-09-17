vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.syntax = "on"
vim.opt.autoindent = true
vim.opt.autochdir = true
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
vim.opt.laststatus = 2
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.completeopt= "menuone,noinsert,noselect"
vim.opt.shortmess:append("c")
vim.opt.diffopt:append("iwhite")
vim.opt.showmatch = true
vim.opt.wrap = false
-- vim.wo.foldmethod = "indent"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext =
--     [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
-- vim.wo.fillchars = "fold: "
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1
