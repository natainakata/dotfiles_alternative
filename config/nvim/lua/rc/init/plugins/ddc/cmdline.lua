local helper = require("rc.lib.helper.ddc")

local spec = {
  "Shougo/ddc-source-cmdline",
  dependencies = {
    "ddc.vim",
    "Shougo/ddc-source-input",
    "Shougo/ddc-source-cmdline-history",
  },
  lazy = false,
  config = function()
    helper.patch_global({
      cmdlineSources = {
        [":"] = { "nvim-lua", "cmdline" },
        ["@"] = { "cmdline-history", "input", "buffer" },
        ["="] = { "input" },
      },
      sourceOptions = {
        cmdline = {
          mark = "[Cmd]",
          keywordPattern = "[\\w#:~_-]*",
          matchers = { "matcher_fuzzy" },
          sorters = { "sorter_fuzzy" },
        },
        input = { mark = "[Input]" },
        ["cmdline-history"] = { mark = "[Hist]" },
      },
    })
  end,
  keys = {
    { ":", "<Cmd>call ddc#enable_cmdline_completion()<CR>:", mode = { "n", "x" } },
    { "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1, 'loop')<CR>", mode = { "c" } },
    { "<C-n>", "<Cmd>call pum#map#insert_relative(+1, 'loop')<CR>", mode = { "c" } },
    { "<C-p>", "<Cmd>call pum#map#insert_relative(-1, 'loop')<CR>", mode = { "c" } },
    { "<C-y>", "<Cmd>call pum#map#confirm()<CR>", mode = { "c" } }

  },
}

return spec
