local M = {}

local bufnr = vim.api.nvim_get_current_buf()
local nmap = function(lhs, rhs, opts)
  opts = opts or {remap = true}
  opts.buffer = bufnr
  vim.keymap.set('n', lhs, rhs, opts)
end

local is_checkbox = function(line)
  local regex = vim.regex([[^\s*- \[.\] ]])
  return regex:match_str(line)
end

local checkbox_set = function(newstate)
  local idx = vim.api.nvim_win_get_cursor(0)[1] - 1
  local line = vim.api.nvim_get_current_line()
  if is_checkbox(line) then
    -- There's a box here we can tick. Tick it.
    local newbox = "[" .. newstate .. "] "
    local newline = vim.fn.substitute(line, [[\[.\] ]], newbox, "")
    if line ~= newline then
      vim.api.nvim_buf_set_lines(0, idx, idx + 1, false, {newline})
    end
  end
end

M.checkbox_is_ticked = function()
  local line = vim.api.nvim_get_current_line()
  local regex = vim.regex([[^\s*- \[x\] ]])
  return regex:match_str(line) and true or false
end

M.checkbox_tick = function()
  checkbox_set("x")
end

M.checkbox_untick = function()
  checkbox_set(" ")
end

M.checkbox_toggle = function()
  if M.checkbox_is_ticked() then
    M.checkbox_untick()
  else
    M.checkbox_tick()
  end
end

M.checklist_indent = function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if is_checkbox(line) then
    if col >= #line then
      vim.cmd([[norm! >>]])
      vim.cmd([[startinsert!]])
    else
      vim.cmd([[norm! >>ll]])
    end
  end
end

M.checklist_dedent = function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if is_checkbox(line) then
    if col >= #line then
      vim.cmd([[norm! <<]])
      vim.cmd([[startinsert!]])
    elseif line:sub(1, 1) == '-' then
      vim.cmd([[norm! <<]])
    else
      vim.cmd([[norm! hh<<]])
    end
  end
end

return M

