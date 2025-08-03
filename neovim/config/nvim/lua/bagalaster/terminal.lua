local state = {
    window = nil,
    buffer = nil,
}

local config = {
    vertical_pad = 10,
    horizontal_pad = 20,
    style = 'minimal',
    title = 'Terminal',
    title_pos = 'left',
}

local function create_window()
    local spawn_terminal = false
    if state.buffer == nil then
	state.buffer = vim.api.nvim_create_buf(false, true)
	spawn_terminal = true
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

    vim.api.nvim_create_autocmd("WinClosed", {
	buffer = state.buffer,
	callback = function()
	    state.window = nil
	end,
    })

    if spawn_terminal then
	vim.fn.jobstart({ "/bin/zsh" }, {
	    term = true,
	    on_exit = function(job_id, exit_code, event_type)
		if state.window ~= nil then
		    vim.api.nvim_win_close(state.window, false)
		end
		state.window = nil
		state.buffer = nil
	    end
	})
    end
end

local function toggle_window()
    if state.window ~= nil then
	vim.api.nvim_win_close(state.window, false)
	state.window = nil
    else
	create_window()
	vim.cmd('startinsert')
    end
end

vim.api.nvim_create_user_command('FloatTerm', function() toggle_window() end, { desc = "Toggle Floating Terminal" })

