local helper = require("rc.lib.helper.ddu")

local spec = {
	{
		"Shougo/ddu-source-file_rec",
		lazy = false,
		dependencies = "ddu.vim",
		config = function()
			helper.patch_local("file:rec", {
				sources = {
					{
						name = "file_rec",
						options = {
							converters = { "converter_devicon" },
						},
					},
				},
			})
		end,
		keys = {
			{ "<Leader>f", "<Cmd>Ddu file:rec<CR>", desc = "Ddu File List" },
		},
	},
	{
		"shun/ddu-source-buffer",
		lazy = false,
		dependencies = "ddu.vim",
		config = function()
			helper.patch_local("buffers", {
				sources = {
					{ name = "buffer" },
				},
			})
		end,
		keys = {
			{ "<Leader>b", "<Cmd>Ddu buffers<CR>", desc = "Ddu Buffer List" },
		},
	},
	{
		"uga-rosa/ddu-source-help",
		lazy = false,
		dependencies = "ddu.vim",
		config = function()
			helper.patch_local("help_tags", {
				sources = {
					{
						name = "help",
						options = {
							defaultAction = "open",
							converters = { "converter_devicon" },
						},
					},
				},
			})
			helper.ff_map("help", function(map)
				map("<C-x>", helper.item_action("open"))
				map("<C-v>", helper.item_action("vsplit"))
				map("<C-t>", helper.item_action("tabopen"))
			end)
			helper.ff_filter_map("help", function(map)
				map("i", "<C-x>", helper.item_action("open"))
				map("i", "<C-v>", helper.item_action("vsplit"))
				map("i", "<C-t>", helper.item_action("tabopen"))
			end)
		end,
		keys = {
			{ "<Leader>?", "<Cmd>Ddu help_tags<CR>", desc = "Ddu Help_Tags" },
		},
	},
	{
		"Shougo/ddu-source-line",
		lazy = false,
		dependencies = "ddu.vim",
		config = function()
			helper.patch_local("search:line", {
				sources = {
					{
						name = "line",
					},
				},
			})
		end,
		keys = {
			{ "<Leader>/", "<Cmd>Ddu search:line<CR>", desc = "Ddu Search Line" },
		},
	},
	{
		"kuuote/ddu-source-mr",
		lazy = false,
		dependencies = {
			"ddu.vim",
			{
				"lambdalisue/mr.vim",
				init = function()
					vim.g["mr#mru#predicates"] = {
						---@param filename string
						---@return boolean
						function(filename)
							return not (filename:find("doc/.*%.txt$") or filename:find("doc/.*%.jax$"))
						end,
					}
				end,
			},
		},
		config = function()
			for _, kind in ipairs({ "mru", "mrw", "mrr" }) do
				helper.patch_local("file:" .. kind, {
					sources = {
						{
							name = "mr",
							options = {
								converters = { "converter_devicon" },
							},
							params = {
								kind = kind,
							},
						},
					},
				})
			end
		end,
		keys = {
			{ "<Leader>w", "<Cmd>Ddu file:mrw<CR>", desc = "Ddu MRW List" },
			{ "<Leader>r", "<Cmd>Ddu file:mru<CR>", desc = "Ddu MRU List" },
		},
	},
	{
		"Shougo/ddu-source-register",
		lazy = false,
		dependencies = "ddu.vim",
		config = function()
			helper.patch_local("register:list", {
				sources = {
					{ name = "register" },
				},
			})
		end,
		keys = {
			{ '<Leader>"', "<Cmd>Ddu register:list<CR>", desc = "Ddu Register List" },
		},
	},
	{
		"shun/ddu-source-rg",
		lazy = false,
		dependencies = "ddu.vim",
		config = function()
			helper.patch_local("file:rg", {
				sources = {
					{
						name = "rg",
						options = {
							volatile = true,
							matchers = {},
							converters = { "converter_devicon" },
						},
					},
				},
				uiParams = {
					ff = {
						ignoreEmpty = false,
					},
				},
			})
		end,
		keys = {
			{ "<Leader>g", "<Cmd>Ddu file:rg<CR>", desc = "Ddu Rg List" },
		},
	},
	{
		"Shougo/ddu-source-dummy",
		dependencies = "ddu.vim",
		lazy = false,
		config = function()
			helper.patch_global({
				sourceOptions = {
					dummy = {
						matchers = {},
						sorters = {},
						converters = {},
					},
				},
			})
			local function is_dummy(items, index)
				return items[index] and items[index].__sourceName == "dummy"
			end
			local function move_ignore_dummy(dir)
				return function()
					local items = vim.fn["ddu#ui#get_items"]()
					local index = vim.fn.line(".") + dir

					while is_dummy(items, index) do
						index = index + dir
					end
					if 1 <= index and index <= #items then
						vim.cmd("normal! " .. index .. "gg")
					end
				end
			end
			helper.ff_map("dummy", function(map)
				-- Move cursor ignoring dummy items
				map("j", move_ignore_dummy(1))
				map("k", move_ignore_dummy(-1))
			end)
		end,
	},
}
return spec
