local M = {}

-- Function to open a file in VS Code using the vscode:// protocol
function M.open_file_in_vscode(file_path)
  local encoded_path = vim.fn.fnameescape(file_path)
  local vscode_url = "vscode://file/" .. encoded_path
  -- Use xdg-open (Unix-based systems) or other equivalents for different platforms
  vim.fn.jobstart({ "xdg-open", vscode_url }, { detach = true })
end

return M
