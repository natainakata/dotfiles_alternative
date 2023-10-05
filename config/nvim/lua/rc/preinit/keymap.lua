local helper = require("rc.lib.helper")
local nmap = helper.nmap
local imap = helper.imap
local xmap = helper.xmap
local cmap = helper.cmap
local tmap = helper.tmap

vim.g.mapleader = " "

-- general
nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")
nmap("U", "<C-r>")
imap("jj", "<Esc>")
nmap("<Esc><Esc>", "<Cmd>nohlsearch<CR>")
nmap("x", [["_x]])

-- buffer
nmap("<S-h>", "<Cmd>bprevious<CR>")
nmap("<S-l>", "<Cmd>bnext<CR>")


--window
nmap("g-", "<Cmd>split<CR><C-w>w")
nmap("g\\", "<Cmd>vsplit<CR><C-w>w")
nmap("<C-h>", "<Cmd>wincmd h<CR>", { remap = true })
nmap("<C-j>", "<Cmd>wincmd j<CR>", { remap = true })
nmap("<C-k>", "<Cmd>wincmd k<CR>", { remap = true })
nmap("<C-l>", "<Cmd>wincmd l<CR>", { remap = true })
nmap("<C-Up>", "<Cmd>resize +2<CR>", { remap = true })
nmap("<C-Down>", "<Cmd>resize -2<CR>", { remap = true })
nmap("<C-Left>", "<Cmd>vertical resize -2<CR>", { remap = true })
nmap("<C-Right>", "<Cmd>vertical resize +2<CR>", { remap = true })

-- fold
nmap("Z", ":set foldmethod=indent<CR>")

-- terminal
nmap("<Leader>t", "<Cmd>terminal<CR>")
nmap("<Leader>T", "<Cmd>belowright new<CR><Cmd>terminal<CR>")
tmap("JJ", "<C-\\><C-n>")
tmap("<Esc><Esc>", "<C-\\><C-n>")
