
-- these are the language servers to maintain
local lang_servers = {
    "lua_ls",
    "pyright",
    -- "sqls",
}

return {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = lang_servers },
    dependencies = {
	{ "mason-org/mason.nvim", opts = {} },
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
	"nanotee/sqls.nvim",
    },
    config = function()
	require('mason').setup()
	require('mason-lspconfig').setup {
	    ensure_installed = lang_servers,
	    automatic_enable = false,
	}
	local cmp = require('cmp')
	local cmp_lsp = require('cmp_nvim_lsp')
	local capabilities = vim.tbl_deep_extend(
	    "force",
	    {},
	    vim.lsp.protocol.make_client_capabilities(),
	    cmp_lsp.default_capabilities()
	)

	for _, server_name in pairs(lang_servers) do
	    vim.lsp.config(server_name, { capabilities = capabilities })
	    vim.lsp.enable(server_name)
	end

	vim.lsp.config('sqlmesh', {
	    capabilities = capabilities,
	    cmd = { '/Users/macbagwell/git/sqlmesh-ls/.venv/bin/python', '/Users/macbagwell/git/sqlmesh-ls/main.py' },
	    filetypes = { 'sql' },
	    root_markers = { 'config.yaml', 'config.py' },

	})
	vim.lsp.enable('sqlmesh')

	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	cmp.setup {
	    snippet = {
		expand = function(args)
		    require('luasnip').lsp_expand(args.body)
		end,
	    },
	    mapping = cmp.mapping.preset.insert {
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	    },
	    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	    }, {
		{ name = 'buffer' },
	    })
	}

	vim.diagnostic.config({
	    update_in_insert = true,
	    virtual_text = true,
	    signs = true,
	})
    end,
}
