-- sets the colorscheme
-- catppuccin is the best

return {
    "catppuccin/nvim",
    name = "cattppuccin",
    priority = 1000,
    config = function() 
	require'catppuccin'.setup({
	    flavour = "mocha",
	})
	vim.cmd.colorscheme "catppuccin"
    end,
}
