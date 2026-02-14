return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        -- refer to `:h file-pattern` for more examples
        "BufReadPre /Users/macbagwell/notes/*.md",
        "BufNewFile /Users/macbagwell/notes/*.md",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local opts = {
            legacy_commands = false,
            workspaces = {
                {
                    name = "notes",
                    path = "~/notes",
                },
            },
            daily_notes = {
                folder = "daily-notes",
                -- Optional, if you want to change the date format for the ID of daily notes.
                date_format = "%Y-%m-%d",
                -- Optional, if you want to change the date format of the default alias of daily notes.
                alias_format = "%B %-d, %Y",
                -- Optional, default tags to add to each new daily note created.
                default_tags = { "daily-notes" },
                -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                template = nil,
            },
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                -- vim.fn.jobstart({"open", url})  -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
                -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
                vim.ui.open(url) -- need Neovim 0.10.0+
            end,
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,
        }
        require("obsidian").setup(opts)

        vim.keymap.set('n', '<leader>it', '^C- [ ] #todo<esc>F#Pa <esc>', { noremap = true })
        vim.keymap.set('n', '<leader>at', '^o- [ ] #todo<esc>F#i <esc>i', { noremap = true })
        vim.keymap.set('n', '<leader>ot', '<cmd>Obsidian tags<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>od', '<cmd>Obsidian today 0<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>ol', '<cmd>Obsidian links<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>ob', '<cmd>Obsidian backlinks<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>on', '<cmd>Obsidian new<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>oq', '<cmd>Obsidian quick_switch<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>oc', function() require("obsidian.util").toggle_checkbox() end, { noremap = true })
    end
}
