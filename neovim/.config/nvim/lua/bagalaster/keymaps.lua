
-- options
-- #######

-- 4 space tabs
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- relative line numbers
vim.opt.relativenumber = true

-- min number of lines to keep at top/bottom
vim.opt.scrolloff = 10

-- keep gutter (sign column) on by default to avoid weird flashing w/ LSP
vim.opt.signcolumn = 'yes'

-- keymaps
-- #######

-- leader is the space key
-- this is moved to lazy.lua to ensure intialization before lazy
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

-- netrw
---
-- when opening netrw, split horizontally first
vim.g.netrw_browse_split = 0
-- surpress banner
vim.g.netrw_banner = 0

-- open up netrw
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>')

-- esc to clear highlighting when searching
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Ctrl+U/D keeps cursor centered
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- paste in visual mode doesn't blow away the contents of the register
vim.keymap.set('v', 'p', '"_dP')

-- move through the quickfix list
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')

-- Floating Terminal
vim.keymap.set('n', '<leader>tt', '<cmd>FloatTerm<CR>')

-- Floating TODO
vim.keymap.set('n', '<leader>to', '<cmd>Todo<CR>')

-- Use esc to exit terminal mode like a normal person
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local bagalaster_group = augroup('bagalaster', {})
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
	vim.hl.on_yank({
	    timeout = 40,
	})
    end
})

autocmd('LspAttach', {
    group = bagalaster_group,
    callback = function(event)
	local opts = { buffer = event.buf }
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)

	vim.lsp.set_log_level('debug')
    end
})

