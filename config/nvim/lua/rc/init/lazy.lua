local lazypath = plugins.lazydir("lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  defaults = {
    lazy = true,
    version = false,
  },
  dev = {
    path = "~/src/github.com/natainakata",
    patterns = {},
  },
  checker = { enabled = true, frequency = 1600 }, -- automatically check for plugin updates
  install = { colorscheme = { "sonokai", "habamax" } }, performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "shada",
        "rplugin",
        "man",
      },
    },
  },
}

plugins.ensure("lazy", function(m)
  m.setup("rc.init.plugins", opts)
  m.load({ plugins = "sonokai" })
end)
