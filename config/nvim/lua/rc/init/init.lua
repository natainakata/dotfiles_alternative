-- 参考: https://github.com/kyoh86/dotfiles/blob/main/nvim/lua/kyoh86/root/preload.lua
local handler = {}

handler.ensure = function(spec, callback, failed)
  local ok, module = pcall(require, spec)
  if ok then
    if callback then
      return callback(module)
    end
  else
    vim.notify(string.format("failed to load module %q", spec), vim.log.levels.WARN)
    if failed then
      failed()
    end
  end
  return ok, module
end

handler.lazydir = function(spec)
  return vim.fs.normalize(vim.fn.stdpath("data") .. "/lazy/" .. spec)
end

--- Get lazy plugins opts table
---@param name string Plugin name
---@return table # Opts table
handler.opts = function(spec)
  handler.ensure("lazy.core.config", function(m)
    local plugin = m.plugins[spec]
    if not plugin then 
      return {}
    end
    return require("lazy.core.plugin").values(plugin, "opts", false)
  end)
end

_G["plugins"] = handler

require("rc.init.lazy")

