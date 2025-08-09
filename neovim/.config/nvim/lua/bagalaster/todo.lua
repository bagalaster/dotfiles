local state = {
    buffer = nil,
    window = nil,
}

local config = {
    vertical_pad = 10,
    horizontal_pad = 20,
    style = 'minimal',
    title = 'TODO',
    title_pos = 'left',
}
local function create_window()
    if state.buffer == nil then
	state.buffer = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_buf_set_name(state.buffer, 'TODO List')
    end

    local window_config = {
	relative = 'editor',
	row = config.vertical_pad,
	col = config.horizontal_pad,
	width = vim.o.columns - 2 * config.horizontal_pad,
	height = vim.o.lines - 2 * config.vertical_pad,
	style = config.style,
	title = config.title,
	title_pos = config.title_pos,
	border = 'rounded',
    }
    state.window = vim.api.nvim_open_win(state.buffer, true, window_config)

    -- Set todo module window state to closed if we close the window for any other reason
    vim.api.nvim_create_autocmd("WinClosed", {
	pattern = "" .. vim.api.nvim_get_current_win(),
	callback = function()
	    state.window = nil
	end,
    })

end

local function toggle_window()
    if state.window ~= nil then
	vim.api.nvim_win_close(state.window, false)
	state.window = nil
    else
	create_window()
	vim.cmd('edit ~/todo.md')
	vim.keymap.set('n', '<leader>xx', function() vim.cmd('TodoCheck') end, { buffer = true })
	vim.keymap.set('n', '<leader>ii', function() vim.cmd('TodoAdd') end, { buffer = true })
    end
end

local function check_todo_item(line)
    local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    local maybe_checkbox = string.sub(current_line, 0, 5)

    local new_content = current_line
    if maybe_checkbox == '- [ ]' then
        new_content = "- [x]" .. string.sub(current_line, 6)
    elseif maybe_checkbox == '- [x]' then
        new_content =  "- [ ]" .. string.sub(current_line, 6)
    end
    vim.api.nvim_buf_set_lines(0, line - 1, line, false, { new_content })
end

local function check_item_over_cursor()
    local cursor = vim.api.nvim_win_get_cursor(state.window)
    check_todo_item(cursor[1])
end

local function add_todo_item(line)
    local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    vim.api.nvim_buf_set_lines(0, line - 1, line, false, { current_line, "- [ ] " })
    vim.api.nvim_win_set_cursor(0, {line + 1, 6})
    vim.api.nvim_feedkeys('a', 'n', false)
end

local function add_todo_item_over_cursor()
    local cursor = vim.api.nvim_win_get_cursor(state.window)
    add_todo_item(cursor[1])
end

vim.api.nvim_create_user_command('Todo', function() toggle_window() end, { desc = "Toggle TODO List" })
vim.api.nvim_create_user_command('TodoCheck', function() check_item_over_cursor() end, { desc = "Check/Uncheck item" })
vim.api.nvim_create_user_command('TodoAdd', function() add_todo_item_over_cursor() end, { desc = "Check/Uncheck item" })

