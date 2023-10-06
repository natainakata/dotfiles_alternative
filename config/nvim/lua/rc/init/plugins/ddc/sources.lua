local helper = require("rc.lib.helper.ddc")

local spec = {
	{
		"uga-rosa/ddc-source-buffer",
		dependencies = "ddc.vim",
		lazy = false,
		config = function()
			helper.patch_global({
				sourceOptions = {
					buffer = { mark = "[Buf]" },
				},
				sourceParams = {
					buffer = {
						getBufnrs = helper.register(function()
							return vim.iter(vim.api.nvim_tabpage_list_wins(0))
								:map(function(win)
									return vim.api.nvim_win_get_buf(win)
								end)
								:totable()
						end),
					},
				},
			})
		end,
	},
	{
		"LumaKernel/ddc-source-file",
		dependencies = "ddc.vim",
		lazy = false,
		config = function()
			helper.patch_global({
				sourceOptions = {
					file = { mark = "[File]" },
				},
				sourceParams = {
					file = {},
				},
			})
		end,
	},
	{
		"uga-rosa/ddc-source-nvim-lua",
		dependencies = "ddc.vim",
		lazy = false,
		config = function()
			helper.patch_global({
				sourceOptions = {
					["nvim-lua"] = {
						mark = "[Lua]",
						dup = true,
						forceCompletionPattern = "\\.",
					},
				},
			})
		end,
	},
	{
		"Shougo/ddc-source-nvim-lsp",
		dependencies = { "ddc.vim", "uga-rosa/ddc-nvim-lsp-setup" },
		lazy = false,
		config = function()
			helper.patch_global({
				sourceOptions = {
					["nvim-lsp"] = {
						mark = "[LSP]",
						dup = "keep",
						keywordPattern = "\\k+",
						sorters = { "sorter_fuzzy", "sorter_lsp-kind" },
					},
				},
				sourceParams = {
					["nvim-lsp"] = {
						snippetEngine = helper.register(function(body)
							vim.fn["vsnip#anonymous"](body)
						end),
						enableResolveItem = true,
						enableAdditionalTextEdit = true,
						-- confirmBehavior = "replace",
					},
				},
			})
		end,
	},
	{
		"uga-rosa/ddc-source-vsnip",
		lazy = false,
		dependencies = {
			"ddc.vim",
			{
				"hrsh7th/vim-vsnip",
				dependencies = "rafamadriz/friendly-snippets",
				init = function()
					vim.g.vsnip_choise_delay = 100
				end,
				keys = {
					{
						"<Tab>",
						function()
							return vim.fn["vsnip#jumpable"](1) == 1 and "<Plug>(vsnip-jump-next)" or "<Tab>"
						end,
						mode = { "i", "s" },
						expr = true,
						replace_keycodes = true,
					},
					{
						"<S-Tab>",
						function()
							return vim.fn["vsnip#jumpable"](-1) == 1 and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
						end,
						mode = { "i", "s" },
						expr = true,
						replace_keycodes = true,
					},
				},
			},
		},
		config = function()
			helper.patch_global({
				sourceOptions = {
					vsnip = {
						mark = "[Vsnip]",
						keywordPattern = "\\S*",
					},
				},
				sourceParams = {
					vsnip = { menu = false },
				},
			})
		end,
	},
}

return spec
