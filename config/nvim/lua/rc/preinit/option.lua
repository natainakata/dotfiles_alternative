local opt = vim.opt

opt.fenc = "utf-8"
opt.backup = false
opt.swapfile = false

opt.expandtab = true
opt.smartindent = true
local indent = 2
opt.tabstop = indent
opt.shiftwidth = indent

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = true
opt.number = true
opt.termguicolors = true
opt.cursorline = true
opt.visualbell = true
opt.wildmode = { "list", "longest" }
-- opt.completeslash = "slash"

opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3
opt.cmdwinheight = 10
opt.cmdheight = 0

opt.virtualedit = "onemore"
opt.mouse = "a"
opt.clipboard:append({ "unnamed", "unnamedplus"})
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
