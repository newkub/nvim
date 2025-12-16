-- Core utility functions

local M = {}

--- Returns the name of the current operating system.
-- @return string "windows", "linux", "mac", or "unknown"
function M.get_os()
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    return "windows"
  elseif vim.fn.has("unix") == 1 then
    local uname = vim.fn.system("uname -s")
    if uname:match("Linux") then
      return "linux"
    elseif uname:match("Darwin") then
      return "mac"
    end
  end
  return "unknown"
end

--- Returns a sensible default shell for the current OS.
-- @return string The shell command (e.g., "pwsh", "bash")
function M.get_default_shell()
  local os = M.get_os()
  if os == "windows" then
    return "pwsh"
  else
    -- On Unix-like systems, prefer zsh if available, then bash.
    if vim.fn.executable("zsh") == 1 then
      return "zsh"
    elseif vim.fn.executable("bash") == 1 then
      return "bash"
    else
      -- Fallback to Neovim's default shell setting
      return vim.o.shell
    end
  end
end

return M
