-- The combined effect of the next few settings is to make it so the text after
-- a checkbox can spill across lines automatically, indenting itself in an
-- attractive fashion.
vim.bo.formatlistpat = [[^\s*- \[.\] ]]
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

-- Hard indentation levels.
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true

-- Basic .mh keywords will be modelled loosely after the ":command-name"
-- keywords in vim's helpfiles.
vim.bo.iskeyword = vim.bo.iskeyword .. ",:"
