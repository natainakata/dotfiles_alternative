local spec = {
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_better_performanec = 1
      vim.g.sonokai_transparent_background = 1

      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        transparent = true,
      },
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
      -- vim.cmd.colorscheme("nightfox")
    end,
  },
}

return spec
