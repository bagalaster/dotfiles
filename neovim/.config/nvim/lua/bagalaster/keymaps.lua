-- options
-- #######

-- 4 space tabs
vim.opt.tabstop = 4       -- Width of tab character
vim.opt.softtabstop = 4   -- How many spaces a tab counts for when editing
vim.opt.shiftwidth = 4    -- How many spaces for indentation operations
vim.opt.expandtab = true  -- Convert tabs to spaces

vim.opt.conceallevel = 2 -- necessary for obsidian to work

-- relative line numbers
vim.opt.relativenumber = true

-- min number of lines to keep at top/bottom
vim.opt.scrolloff = 10

-- keep gutter (sign column) on by default to avoid weird flashing w/ LSP
vim.opt.signcolumn = 'yes'

-- Display a vertical line at column 120
vim.opt.colorcolumn = "120"

-- Auto-update files on change
vim.opt.autoread = true


-- keymaps
-- #######

-- netrw
---
-- when opening netrw, split horizontally first
vim.g.netrw_browse_split = 0
-- surpress banner
vim.g.netrw_banner = 0

-- open up netrw
--vim.keymap.set('n', '<leader>pv', '<cmd>pv<CR>')

-- esc to clear highlighting when searching
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Ctrl+U/D keeps cursor centered
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- paste in visual mode doesn't blow away the contents of the register
vim.keymap.set('v', 'p', '"_dP')

-- Open oil
vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>')
-- Toggle neotree
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>')

-- Octo
vim.keymap.set('n', '<leader>o', '<cmd>Octo<CR>')

-- Floating Terminal
vim.keymap.set('n', '<leader>tt', '<cmd>FloatTerm<CR>')
vim.keymap.set('n', '<leader>cc', '<cmd>Claude<CR>')

-- Use esc to exit terminal mode like a normal person
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Telescope pickers
local builtin = require 'telescope.builtin'
local is_current_directory_git = function()
  local current_dir = vim.fn.getcwd()

  local handle = vim.uv.fs_scandir(current_dir)
  if handle == nil then
    error("Error scanning directory")
  end

  while true do
    local name, _ = vim.uv.fs_scandir_next(handle)
    if name == nil then break end
    if name == ".git" then return true end
  end

  return false
end

vim.keymap.set('n', '<leader>ff', function()
    if is_current_directory_git() then
        builtin.git_files({ show_untracked = true })
    else
        builtin.find_files()
    end
end, {})
vim.keymap.set('n', '<leader>fg', function() builtin.git_files({ show_untracked = true }) end, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fws', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<Tab>', builtin.buffers, {})

-- Neogit
vim.keymap.set('n', '<leader>gs', function() require('neogit').open({ kind = "auto" }) end)
vim.keymap.set('n', '<leader>gc', function() require('neogit').open({ "commit", kind = "replace" }) end)
vim.keymap.set('n', '<leader>gp', function() require('neogit').open({ "pull", kind = "split" }) end)
vim.keymap.set('n', '<leader>gP', function() require('neogit').open({ "push", kind = "split" }) end)
vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk)

-- Obsidian todos
vim.keymap.set('n', '<leader>td', function()
    local picker = require'bagalaster.obsidian_telescope'.picker
    picker(require('telescope.themes').get_ivy{ layout_config = { height = 15, }, })
end, { noremap =  true })

-- autocommands
local augroup = vim.api.nvim_create_augroup
local bagalaster_group = augroup('bagalaster', {})
local yank_group = augroup('HighlightYank', {})
local format_group = augroup('AutoFormat', {})

local autocmd = vim.api.nvim_create_autocmd

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
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format() end)
    end
})

autocmd('BufWritePre', {
    group = format_group,
    pattern = "*.py,*.ts,*.tsx,*.js,*.go",
    callback = function()
        vim.lsp.buf.format({ async = true })
    end
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            timeout = 40,
        })
    end
})

-- Auto-save when leaving a buffer or when focus is lost
local autosave_group = augroup('AutoSave', {})
autocmd({'BufLeave', 'FocusLost'}, {
    group = autosave_group,
    pattern = "*",
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
            vim.cmd('silent! write')
        end
    end,
    desc = "Auto-save when leaving buffer or losing focus"
})
