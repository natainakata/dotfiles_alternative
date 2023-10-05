local helper = require("rc.lib.helper")
local icons = require("rc.lib.icons")
local spec = {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", "NvimTreeOpen" },
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree" },
    },
    opts = {
      disable_netrw = false,
      hijack_netrw = true,
      filters = {
        dotfiles = true,
      },
      renderer = {
        icons = {
          glyphs = {
            git = {
              unstaged = icons.files.modified,
              staged = icons.git.staged,
              unmerged = icons.git.merged,
              renamed = icons.git.renamed,
              untracked = icons.git.added,
              deleted = icons.git.removed,
              ignored = icons.git.ignored,
            },
          },
        },
      },
    },
    config = function(_, opts)
      plugins.ensure("nvim-tree", function(m)
        m.setup(opts)
        helper.autocmd("nvim-tree-close", "BufEnter", {
        pattern = "NvimTree_*",
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if
            layout[1] == "leaf"
            and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
            and layout[3] == nil
          then
            vim.cmd("confirm quit")
          end
        end,
      })
      end)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        border = "none",
      },
    },
    config = function(_, opts)
      plugins.ensure("which-key", function(m)
        m.setup(opts)
        local keymaps = {
          mode = { "n", "v" },
          ["<leader>d"] = { name = "+dap" },
          ["<leader>I"] = { name = "+iron" },
          ["<leader>l"] = { name = "+lsp" },
          ["<leader>n"] = { name = "+noice" },
          ["<C-g>"] = { name = "+git" },
          ["<leader><tab>"] = { name = "+tab" },
        }
        m.register(keymaps)
      end)
    end,
  },
  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { "<Leader>h", ":<C-u>HopWord<CR>", silent = true, desc = "Hop Word" },
      { "<Leader>H", ":<C-u>HopPattern<CR>", silent = true, desc = "Hop Pattern" },
      { "<Leader>L", ":<C-u>HopLineStart<CR>", silent = true, desc = "Hop Line" },
    },
  }, 
  {
    "echasnovski/mini.jump",
    config = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "kevinhwang91/nvim-bqf",
    config = true,
    ft = "qf",
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    -- stylua: ignore
     keys = {
       { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
       { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
     },
  },
  {
    "lambdalisue/gin.vim",
    dependencies = "vim-denops/denops.vim",
    lazy = false,
  },
}

return spec
