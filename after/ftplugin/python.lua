vim.opt_local.expandtab = false
vim.opt_local.tabstop = 2

vim.opt_local.list = true
vim.opt_local.listchars = {
  tab = "\\t",
  trail = "s",
  space = "s",
  nbsp = "␣",
}

vim.keymap.set("i", "<Tab>", "<C-v><Tab>", {
  buffer = true,
})

-- Disable automatic indentation for lexer testing
vim.opt_local.autoindent = false
vim.opt_local.indentexpr = ""

vim.schedule(function()
  vim.opt_local.autoindent = false
end)
