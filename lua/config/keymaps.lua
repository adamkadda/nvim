vim.g.mapleader = " "

-- Explore
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex)

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Window focus
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Window split & focus
vim.keymap.set("n", "<leader>hs", "<cmd>leftabove vsplit<CR><C-h>")
vim.keymap.set("n", "<leader>js", "<cmd>belowright split<CR><C-j>")
vim.keymap.set("n", "<leader>ks", "<cmd>aboveleft split<CR><C-k>")
vim.keymap.set("n", "<leader>ls", "<cmd>rightbelow vsplit<CR><C-l>")

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- https://yobibyte.github.io/vim.html
vim.keymap.set("n", "<space>c", function()
  vim.ui.input({}, function(c)
    if c and c ~= "" then
      vim.cmd("noswapfile vnew")
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "wipe"
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
    end
  end)
end)
