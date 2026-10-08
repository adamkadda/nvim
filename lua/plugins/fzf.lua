-- A little hacky, but gets it done
vim.opt.pumheight = 5

-- A little hacky, but gets it done
vim.opt.pumheight = 5

if vim.fn.executable("rg") == 1 then
  local find_root = vim.fn.getcwd()

  function _G.RgFindFiles(cmdarg, _cmdcomplete)
    local result = vim
      .system({
        "rg",
        "--files",
        "--hidden",
        "--color=never",
        "--glob=!.git",
      }, {
        cwd = find_root,
      })
      :wait()

    local fnames = vim.split(result.stdout, "\n", { trimempty = true })

    if #cmdarg == 0 then
      return fnames
    else
      return vim.fn.matchfuzzy(fnames, cmdarg)
    end
  end

  vim.o.findfunc = "v:lua.RgFindFiles"
end

local function is_cmdline_type_find()
  local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), " ")[1]

  return cmdline_cmd == "find" or cmdline_cmd == "fin"
end

vim.api.nvim_create_autocmd({ "CmdlineChanged", "CmdlineLeave" }, {
  pattern = { "*" },
  group = vim.api.nvim_create_augroup("CmdlineAutocompletion", { clear = true }),
  callback = function(ev)
    local function should_enable_autocomplete()
      local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), " ")[1]

      return is_cmdline_type_find() or cmdline_cmd == "help" or cmdline_cmd == "h"
    end

    if ev.event == "CmdlineChanged" and should_enable_autocomplete() then
      vim.opt.wildmode = "noselect:lastused,full"
      vim.fn.wildtrigger()
    end

    if ev.event == "CmdlineLeave" then
      vim.opt.wildmode = "full"
    end
  end,
})

vim.keymap.set("n", "<leader>f", ":find<space>", { desc = "Fuzzy find" })
vim.keymap.set("c", "<m-e>", "<home><s-right><c-w>edit<end>", { desc = "Change to :edit" })
vim.keymap.set("c", "<m-d>", function()
  if not is_cmdline_type_find() then
    vim.notify("This binding should be used with :find", vim.log.levels.ERROR)
    return
  end

  local cmdline_arg = vim.fn.split(vim.fn.getcmdline(), " ")[2]

  if vim.uv.fs_realpath(vim.fn.expand(cmdline_arg)) == nil then
    vim.notify("The second argument should be a valid path", vim.log.levels.ERROR)
    return
  end

  local keys = vim.api.nvim_replace_termcodes("<C-U>edit " .. vim.fs.dirname(cmdline_arg), true, true, true)
  vim.fn.feedkeys(keys, "c")
end, { desc = "Edit the dir for the path" })

vim.keymap.set("c", "<c-v>", "<home><s-right><c-w>rightbelow vsplit<end>", {
  desc = "Change command to :rightbelow vsplit",
})

vim.keymap.set("c", "<c-s>", "<home><s-right><c-w>belowright split<end>", {
  desc = "Change command to :belowright split",
})

vim.keymap.set("c", "<c-t>", "<home><s-right><c-w>tabe<end>", { desc = "Change to :tabe" })
