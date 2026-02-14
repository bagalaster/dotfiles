require('bagalaster')

function _G.list_current_dir()
  local current_dir = vim.fn.getcwd()
  local files = {}

  local handle = vim.uv.fs_scandir(current_dir)
  if handle == nil then
    error("Error scanning directory")
  end

  while true do
    local name, _ = vim.uv.fs_scandir_next(handle)
    if name == nil then break end
    table.insert(files, name) -- Add the file name to the list
  end

  return files
end

