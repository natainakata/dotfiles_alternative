local helper = require("rc.lib.helper.ddu")
local spec = {
  {
    "Shougo/ddu-filter-matcher_substring",
    lazy = false,
    dependencies = "ddu.vim",
    config = function()
      helper.patch_global({
        sourceOptions = {
          ['_'] = {
            matchers = {
              "matcher_substring",
            },
          },
        },
        filterOptions = {
          matcher_substring = {
            highlightMatched = "Title",
          },
        },
      })
    end,
  },
  {
    "uga-rosa/ddu-filter-converter_devicon",
    lazy = false,
    dependencies = "ddu.vim",
  },
}

return spec
