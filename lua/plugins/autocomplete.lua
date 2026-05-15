vim.pack.add({ { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") } })
require("luasnip").setup({})

vim.pack.add({ "https://github.com/saghen/blink.lib" })
vim.pack.add({ "https://github.com/saghen/blink.cmp" })
require("blink.cmp").setup({
  keymap = {
    preset = "default",
  },

  completion = {
    documentation = { auto_show = true },
  },

  sources = {
    default = { "lsp", "path", "snippets" },
  },

  fuzzy = {
    implementation = "prefer_rust",
  },

  signature = {
    enabled = true,
  },
})
