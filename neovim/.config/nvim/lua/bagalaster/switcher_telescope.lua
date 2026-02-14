local pickers = require 'telescope.pickers'
local entry_display = require 'telescope.pickers.entry_display'
local finders = require 'telescope.finders'
local previewers = require 'telescope.previewers.buffer_previewer'
local actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'
local config = require 'telescope.config'.values
local switcher = require("bagalaster.switcher")

local M = {}

local hotkeys = {'R', 'E', 'W', 'Q'}
local number_to_hotkey = function(x)
    if x >= 1 and x <= 4 then
        return hotkeys[x]
    end

    return ' '
end

M.picker = function(opts)
    opts = opts or {}
    local buffer_numbers = switcher.stored_buffers
    local buffer_names = {}
    for i, buffer_number in ipairs(buffer_numbers) do
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        table.insert(buffer_names, { i, buffer_name })
    end

    local displayer = entry_display.create {
        separator = " | ",
        items = {
            { width = 3 },
            { remaining = true },
        }
    }

    local make_dislpay = function(entry)
        return displayer {
            " " .. number_to_hotkey(entry.value[1]) .. " ",
            entry.value[2],
        }
    end

    pickers.new(opts, {
        prompt_title = "File name",
        finder = finders.new_table({
            results = buffer_names,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = make_dislpay,
                    ordinal = entry[2],
                    path = entry[2],
                }
            end
        }),
        sorter = config.generic_sorter(opts),
        previewer = previewers.cat.new(opts),
        attach_mappings = function(prompt_bufnr, map)
            map({"i", "n"}, "<C-d>", function(_prompt_bufnr)
                local entry = actions_state.get_selected_entry()
                switcher.remove_stored_buffer(entry[1])
                actions.close(_prompt_bufnr)
            end)

            for i, char in ipairs(hotkeys) do
                map({"i", "n"}, "<C-" .. char .. ">", function(_prompt_bufnr)
                    actions.close(_prompt_bufnr)
                    switcher.switch_to_stored_buffer(i)
                end)
            end
            return true
        end,
    }):find()
end

return M
