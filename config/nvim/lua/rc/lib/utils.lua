local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts, method)
	opts = opts or {}
	return default and vim.tbl_deep_extend(method, default, opts) or opts
end

function M.diff_source()
	plugins.ensure("gitsigns", function(m)
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end)
end

return M
