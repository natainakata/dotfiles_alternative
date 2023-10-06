local M = {}
local utils = require("rc.lib.utils")

local default_key_opts = { silent = true, noremap = true }

--- Normal mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.nmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("n", lhs, rhs, opts)
end

--- Insert mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.imap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("i", lhs, rhs, opts)
end

--- Visual mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.xmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("v", lhs, rhs, opts)
end

--- cmdline mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.cmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("c", lhs, rhs, opts)
end


--- Terminal mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.tmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("t", lhs, rhs, opts)
end

function M.autocmd(name, event, opts)
  opts = opts or {}
  opts = vim.tbl_deep_extend("force", opts, {
    group = vim.api.nvim_create_augroup("natai_" .. name, { clear = true }),
  })
  vim.api.nvim_create_autocmd(event, opts)
end


M.ddu = require("rc.lib.helper.ddu")

M.ddc = require("rc.lib.helper.ddc")

M.lsp = require("rc.lib.helper.lsp")

return M
