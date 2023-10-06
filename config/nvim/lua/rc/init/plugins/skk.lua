local helper = require("rc.lib.helper")
local spec = {
	"vim-skk/skkeleton",
	lazy = false,
	dependencies = {
		"vim-denops/denops.vim",
		{ "delphinus/skkeleton_indicator.nvim", config = true },
		"kei-s16/skkeleton-azik-kanatable",
		"ddc.vim",
	},
	config = function()
		vim.fn["denops#plugin#wait_async"]("skkeleton", function()
			-- vim.fn["skkeleton#register_keymap"]("input", "", "henkanPoint")
			vim.fn["skkeleton#azik#add_table"]("us")
			local dictionaries = {
				"~/.skk/SKK-JISYO.L",
			}
			vim.fn["skkeleton#config"]({
				eggLikeNewline = true,
				registerConvertResult = true,
				kanaTable = "azik",
				globalDictionaries = dictionaries,
				userJisyo = "~/.skk/SKK-JISYO.user",
			})
			vim.fn["skkeleton#register_kanatable"]("azik", {
				kf = { "き", "" },
				jf = { "じゅ", "" },
				hf = { "ふ", "" },
				yf = { "ゆ", "" },
				mf = { "む", "" },
				nf = { "ぬ", "" },
				df = { "で", "" },
				cf = { "ちぇ", "" },
				pf = { "ぽん", "" },
			})
			vim.fn["skkeleton#initialize"]()

			helper.ddc.patch_global({
				sourceOptions = {
					skkeleton = {
						mark = "[Skk]",
						matchers = { "skkeleton" },
						sorters = {},
						converters = {},
						isVolatile = true,
					},
				},
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "skkeleton-enable-post",
				callback = function()
					helper.ddc.patch_buffer("sources", helper.ddc.sources.skkeleton)
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "skkeleton-disable-post",
				callback = function()
					helper.ddc.remove_buffer("sources")
				end,
			})
		end)
	end,
	keys = {
		{ "<C-j>", "<Plug>(skkeleton-toggle)", mode = { "i", "c" } },
	},
}

return spec
