-- telescope config
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function(_, opts)
        local ivy_theme = require('telescope.themes').get_ivy({ layout_config = { height = 15, }, })
        opts.defaults = ivy_theme
        return opts
    end
}
