local helper = require("rc.lib.helper.ddc")

local sources = {
	default = { "vsnip", "nvim-lsp", "buffer" },
	-- skkeleton = { "skkeleton" },
	lua = { "vsnip", "nvim-lua", "nvim-lsp", "buffer" },
}

local spec = {
	"Shougo/ddc.vim",
	name = "ddc.vim",
	lazy = false,
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/pum.vim",
		"Shougo/ddc-ui-pum",
		"tani/ddc-fuzzy",
	},
	import = "rc.init.plugins.ddc",
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyPluginPost:lexima",
			callback = function()
				vim.keymap.set("i", "<CR>", function()
					local info = vim.fn["pum#complete_info"]()
					if info.pum_visible then
						if info.selected >= 0 then
							vim.fn["pum#map#confirm"]()
						else
							return vim.fn["ddc#map#insert_item"](0)
						end
					elseif vim.fn["vsnip#expandable"]() == 1 then
						return vim.keycode("<Plug>(vsnip-expand)")
					else
						return vim.fn["lexima#expand"]("<CR>", "i")
					end
				end, { silent = true, expr = true, replace_keycodes = false })
			end,
			once = true,
		})
	end,
	config = function()
		vim.fn["pum#set_option"]({
			item_orders = { "kind", "space", "abbr", "space", "menu" },
			scrollbar_char = "┃",
		})
		helper.patch_global({
			ui = "pum",
			autoCompleteEvents = {
				"InsertEnter",
				"TextChangedI",
				"TextChangedP",
				"CmdlineEnter",
				"CmdlineChanged",
				"TextChangedT",
			},
			backspaceCompletion = true,
			sourceOptions = {
				_ = {
					minAutoCompleteLength = 1,
					keywordPattern = [[(?:-?\d+(?:\.\d+)?|[a-zA-Z_]\w*(?:-\w*)*)]],
					matchers = { "matcher_fuzzy" },
					sorters = { "sorter_fuzzy" },
					converters = { "converter_fuzzy" },
					ignoreCase = true,
				},
			},
			sources = sources.default,
		})
		for ft, source in pairs(sources) do
			if ft ~= "default" and ft ~= "skkeleton" then
				helper.patch_filetype(ft, {
					sources = source,
				})
			end
		end

		helper.patch_filetype("vim", {
			keywordPattern = "(?:[a-z]:)?\\k*",
		})

		helper.patch_global({
			sourceOptions = {
				menu = {
					forceCompletionPattern = ".*",
				},
			},
			sourceParams = {
				menu = {
					items = {
						{ sourceName = "file", lhs = "<C-f>" },
						{ sourceName = "buffer", lhs = "<C-b>" },
					},
				},
			},
		})

		vim.fn["ddc#enable"]()
	end,
	keys = {
		{
			"<C-Space>",
			function()
				if vim.fn["ddc#visible"]() then
					return vim.fn["ddc#hide"]("Manual")
				elseif vim.bo.filetype == "lua" then
					return vim.fn["ddc#map#manual_complete"]({ sources = { "nvim-lua", "nvim-lsp" } })
				elseif #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
					return vim.fn["ddc#map#manual_complete"]({ sources = { "nvim-lsp" } })
				else
					return vim.fn["ddc#map#manual_complete"]({ sources = { "buffer" } })
				end
			end,
			mode = { "i" },
			expr = true,
			replace_keycodes = true,
		},
		{ "<C-n>", "<Cmd>call pum#map#insert_relative(+1, 'loop')<CR>", mode = { "i" } },
		{ "<C-p>", "<Cmd>call pum#map#insert_relative(-1, 'loop')<CR>", mode = { "i" } },
	},
}

return spec
