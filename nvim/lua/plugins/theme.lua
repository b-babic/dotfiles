return {
    'datsfilipe/vesper.nvim',
	-- lazy = false,
	priority = 1000,
	config = function()
        local vesper = require('vesper')

        vesper.setup({
            transparent = true, -- Boolean: Sets the background to transparent
            italics = {
                comments = false, -- Boolean: Italicizes comments
                keywords = false, -- Boolean: Italicizes keywords
                functions = false, -- Boolean: Italicizes functions
                strings = false, -- Boolean: Italicizes strings
                variables = false, -- Boolean: Italicizes variables
            },
            overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
            palette_overrides = {}
        });

        -- Set the theme
		vim.cmd("colorscheme vesper")
	end,
}
