local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts, method)
  opts = opts or {}
  return default and vim.tbl_deep_extend(method, default, opts) or opts
end

return M
