-- these are the language servers to maintain
local lang_servers = {
    "lua_ls",
    -- "stylua",
    "pyright",
    "ruff",
    "ts_ls",
    "gopls",
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_lsp = require('cmp_nvim_lsp')
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = lang_servers,
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        vim.lsp.config(server_name, {
                            capabilities = capabilities
                        })
                        vim.lsp.enable(server_name)
                    end,
                },
                pyright = function()
                    require('lspconfig')['pyright'].setup {
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    ignore = { '*' },
                                },
                                pythonPath = vim.fn.getcwd() .. '.venv/bin/python'
                            }
                        }
                    }
                end,
                lua_ls = function()
                    vim.lsp.config('lua_ls', {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                format = {
                                    enable = true,
                                    defaultConfig = {
                                        indent_style = "space",
                                        indent_width = 4,
                                    }
                                }
                            }
                        }
                    })
                    vim.lsp.enable('lua_ls')
                end,
                ts_ls = function()
                    vim.lsp.config('ts_ls', {
                        capabilities = capabilities,
                    })
                    vim.lsp.enable('ts_ls')
                end,
                gopls = function()
                    vim.lsp.config('gopls', {
                        capabilities = capabilities,
                        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
                        settings = {
                            gopls = {
                                gofumpt = true
                            }
                        }
                    })
                    vim.lsp.enable('gopls')
                end
            }

            vim.diagnostic.config({
                update_in_insert = true,
                virtual_text = true,
                underline = true,
                signs = false,
            })


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
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
            }
        end,
    },
    {
        "petertriho/cmp-git",
        dependencies = { 'hrsh7th/nvim-cmp' },
        opts = {
            -- options go here
        },
        init = function()
            table.insert(require("cmp").get_config().sources, { name = "git" })
        end
    },
}
