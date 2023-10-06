local spec = {
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = function()
			local sonokai_conf = vim.fn["sonokai#get_configuration"]()
			local palette = vim.fn["sonokai#get_palette"](sonokai_conf.style, sonokai_conf.colors_override)
			return { background_colour = palette.bg0[1] }
		end,
		keys = {
			{
				"<leader>nu",
				function()
					plugins.ensure("notify", function(m)
						m.dismiss({ silent = true, pending = true })
					end)
				end,
				desc = "Delete all Notifications",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-notify",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			cmdline = {
				view = "cmdline",
			},
			views = {
				mini = {
					win_options = {
						winblend = 10,
						winhighlight = {
							Normal = "StatusLine",
						},
					},
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		-- opts = {
		--   input = {
		--     enabled = true,
		--     win_options = {
		--       winhighlight = "NormalFloat"
		--     }
		--   },
		--   select = {
		--     enabled = true,
		--     backend = { "telescope" },
		--   }
		-- },
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
		},
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			insert_at_start = true,
		},
		keys = {
			{ "<S-h>", "<Cmd>BufferPrevious<CR>" },
			{ "<S-l>", "<Cmd>BufferNext<CR>" },
		},
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"petertriho/nvim-scrollbar",
		},
		config = true,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},
}

return spec
