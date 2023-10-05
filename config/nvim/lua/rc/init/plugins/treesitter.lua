local spec = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = function()
      plugins.ensure("nvim-treesitter.install", function(m)
        m.update({ with_sync = true })
      end)
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", config = true },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-endwise",
      "andymass/vim-matchup",
    },
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      ensure_installed = {
        -- shell
        "bash",
        -- documents
        "markdown",
        "markdown_inline",
        -- build tool
        "make",
        "cmake",
        -- conf file
        "toml",
        "yaml",
        "json",
        -- vim conf
        "vim",
        "lua",
        -- script
        -- "typescript",
        "python",
      },
      autotag = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },

          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
      matchup = {
        enable = true,
      },
    },
    config = function(_, opts)
      plugins.ensure("nvim-treesitter.configs", function(m)
        m.setup(opts)
        -- vim.treesitter.language.register("typescript", "typescriptreact")
        vim.treesitter.language.register("bash", "zsh")
      end)
    end,
  }
}

return spec
