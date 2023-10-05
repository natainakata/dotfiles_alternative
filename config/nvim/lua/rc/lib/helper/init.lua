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

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  })
end

M.ddu = require("rc.lib.helper.ddu")

return M
