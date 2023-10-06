local helper = require("rc.lib.helper")
local lsp = helper.lsp
local utils = require("rc.lib.utils")

local function servers()
  return {
    lua_ls = require("rc.init.plugins.lsp.settings.lua"),
    denols = require("rc.init.plugins.lsp.settings.deno"),
    pyright = {},
    tsserver = {},
    vimls = {},
    kotlin_language_server = require("rc.init.plugins.lsp.settings.kotlin"),
  }
end

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/trouble.nvim", dependencies = "nvim-web-devicons" },
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mhartington/formatter.nvim",
      "Shougo/ddc-source-nvim-lsp",
    },
    init = function()
      lsp.on_attach(function(client, bufnr)
        require("rc.init.plugins.lsp.keymaps")
      end)
    end,
    opts = require("rc.init.plugins.lsp.opts"),
    config = function(_, opts)
      plugins.ensure("lspconfig", function(m)
        plugins.ensure("ddc_nvim_lsp_setup", function(d)
          d.setup()
        end)
        local function setup(client, server_opts)
          local default_opts = client.document_config.default_config
          local local_opts = utils.extend_tbl(opts, server_opts, "force")

          local_opts.filetypes =
            utils.extend_tbl(local_opts.filetypes or default_opts.filetypes or {}, local_opts.extara_filetypes, "force")
          local_opts.extra_filetypes = nil
          client.setup(local_opts)
        end

        for name, opt in pairs(servers()) do
          setup(m[name], opt)
        end
      end)
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "luacheck",
        "shellcheck",
        "shfmt",
        "stylua",
        "flake8",
        "prettier",
        "lua-language-server",
        "vim-language-server",
      },
    },
    build = function()
      plugins.ensure("mason-registry", function(m)
        m.update()
      end)
    end,
    config = function(_, opts)
      plugins.ensure("mason", function(m)
        m.setup(opts)
        local mr = require("mason-registry")
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "mhartington/formatter.nvim",
    keys = { "<Leader>F", "<Cmd>Format<CR>" },
    config = function()
      plugins.ensure("formatter", function(m)
        m.setup({
          filetype = {
            lua = {
              require("formatter.filetypes.lua").stylua,
            },
            ["*"] = {
              require("formatter.filetypes.any").remove_trailing_whitespace,
            },
          },
        })
        helper.autocmd("formatter", "BufWritePost", {
          command = "FormatWrite",
        })
      end)
    end,
  },
}

return spec
