local spec = {
	{
		"cohama/lexima.vim",
		event = "InsertEnter",
	},
	{
		"monaqa/dial.nvim",
		keys = {
			{ "+", "<Plug>(dial-increment)", desc = "Increment" },
			{ "-", "<Plug>(dial-decrement)", desc = "Decrement" },
		},
		config = function()
			plugins.ensure("dial.config", function(dial)
				local augend = require("dial.augend")
				dial.augends:register_group({
					-- augends used when group with name `mygroup` is specified
					default = {
						augend.integer.alias.decimal,
						augend.integer.alias.hex,
						augend.constant.alias.bool,
						augend.date.alias["%Y/%m/%d"],
					},
				})
			end)
		end,
	},
	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
}

return spec
