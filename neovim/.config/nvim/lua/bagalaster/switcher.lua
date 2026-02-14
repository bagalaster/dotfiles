local M = {}

M.stored_buffers = {}

M.store_current_buffer = function()
    local current_buffer = vim.api.nvim_get_current_buf()
    for _, buffer in ipairs(M.stored_buffers) do
        if buffer == current_buffer then
            return
        end
    end
    table.insert(M.stored_buffers, current_buffer)
end

M.remove_stored_buffer = function(index)
    table.remove(M.stored_buffers, index)
end

M.set_stored_buffer = function(index)
    local current_buffer = vim.api.nvim_get_current_buf()
    M.stored_buffers[index] = current_buffer
end

M.switch_to_stored_buffer = function(index)
    local target_buffer = M.stored_buffers[index]
    if target_buffer == nil or target_buffer == -1 then
        return
    end
    vim.api.nvim_set_current_buf(target_buffer)
end

return M

