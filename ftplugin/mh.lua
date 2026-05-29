local M = {}

local bufnr = vim.api.nvim_get_current_buf()
local nmap = function(lhs, rhs, opts)
  opts = opts or {remap = true}
  opts.buffer = bufnr
  vim.keymap.set('n', lhs, rhs, opts)
end

local checkbox_set = function(newstate)
  local idx = vim.api.nvim_win_get_cursor(0)[1] - 1
  local line = vim.api.nvim_get_current_line()
  local regex = vim.regex([[^\s*- \[.\] ]])
  if regex:match_str(line) then
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

-- The combined effect of the next few settings is to make it so the text after
-- a checkbox can spill across lines automatically, indenting itself in an
-- attractive fashion.
vim.bo.formatlistpat = [[^s*- \[.\] ]]
vim.bo.formatoptions = 'l'
vim.wo.breakindent = true
vim.wo.breakindentopt = "list:6"
vim.wo.lbr = true
vim.wo.wrap = true

-- The combined effect of the next couple lines is to cause vim to auto-
-- populate a newly-opened line with "- [ ] " if the line it is opened
-- from was itself a list item.
vim.bo.comments = [[:- [ ] ,s:- [x] ,m:- [ ] ,e:- [ ] ]]
vim.bo.formatoptions = vim.bo.formatoptions .. 'ro/'

return M

