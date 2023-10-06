local M = {}

function M.patch_global(...)
  vim.fn["ddc#custom#patch_global"](...)
end

function M.patch_filetype(...)
  vim.fn["ddc#custom#patch_filetype"](...)
end

function M.patch_buffer(...)
  vim.fn["ddc#custom#patch_buffer"](...)
end

function M.alias(type, alias, base)
  vim.fn["ddc#custom#alias"](type, alias, base)
end

function M.register(fun)
  return vim.fn["denops#callback#register"](fun)
end

function M.remove_buffer(...)
  local options = vim.fn["ddc#custom#get_buffer"]()
  local root = options
  local keys = { ... }
  local last_key = table.remove(keys)
  for _, key in ipairs(keys) do
    options = options[key]
  end
  options[last_key] = nil
  if vim.tbl_isempty(root) then
    root = vim.empty_dict()
  end
  vim.fn["ddc#custom#set_buffer"](root)
end

return M
