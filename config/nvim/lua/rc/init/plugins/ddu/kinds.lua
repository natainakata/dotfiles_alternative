local helper = require("rc.lib.helper.ddu")

local spec = {
  {
    "Shougo/ddu-kind-file",
    lazy = false,
    dependencies = "ddu.vim",
    config = function()
      helper.patch_global({
        kindOptions = {
          file = {
            defaultAction = "open",
          },
        },
      })
      
      helper.ff_map("file", function(map)
        -- Open file
        map("<C-x>", helper.item_action("open", { command = "split" }))
        map("<C-v>", helper.item_action("open", { command = "vsplit" }))
        -- map("<C-t>", helper.item_action("openProject"))
        -- Send quickfix
        map("q", helper.item_action("quickfix"))
      end)
      
      helper.ff_filter_map("file", function(map)
        -- Open file
        map("i", "<C-x>", helper.item_action("open", { command = "split" }, true))
        map("i", "<C-v>", helper.item_action("open", { command = "vsplit" }, true))
        -- map("i", "<C-t>", helper.item_action("openProject", nil, true))
      end)
    end,
  },
  {
    "Shougo/ddu-kind-word",
    lazy = false,
    dependencies = "ddu.vim",
    config = function()
      helper.patch_global({
        kindOptions = {
          word = {
            defaultAction = "append",
          }
        }
      })
    end
  }
}

return spec
