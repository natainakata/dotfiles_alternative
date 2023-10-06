---@type table<string, fun(...: unknown): boolean>
vim.bool_fn = setmetatable({}, {
  __index = function(_, key)
    return function(...)
      local v = vim.fn[key](...)
      return vim.fn.empty(v) == 0
    end
  end,
})
