vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup({})

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

vim.lsp.config("lua_ls", {
  on_init = function(client)
    -- Disable formatting
    client.server_capabilities.documentFormattingProvider = false

    -- Apply .luarc.json config file when applicable
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
        path = { "lua/?.lua", "lua/?/init.lua" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }),
      },
    })
  end,
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      format = { enable = false },
    },
  },
})

vim.lsp.config("jdtls", {
  settings = {
    java = {
      -- Custom eclipse.jdt.ls options go here
    },
  },
})
vim.lsp.enable("jdtls")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  automatic_enable = true,
})
require("mason-tool-installer").setup({
  ensure_installed = { "stylua" },
  auto_update = true,
})
