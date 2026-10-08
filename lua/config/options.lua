-- vim.o.number = true
vim.o.scrolloff = 20

-- Search settings
vim.o.ignorecase = false
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.inccommand = "split"

-- Visual settings
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.showmatch = true
vim.o.breakindent = true
vim.o.cursorline = true
vim.opt.ruler = false
vim.o.showmode = false

-- Horizontal separator
vim.o.statusline = " "
local line = "#555555"

vim.api.nvim_set_hl(0, "StatusLine", {
  fg = line,
  bg = line,
})

vim.api.nvim_set_hl(0, "StatusLineNC", {
  fg = line,
  bg = line,
})

-- QOL
vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.o.confirm = true

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_liststyle = 0
