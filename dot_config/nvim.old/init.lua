function Safe(package)
  local status, module = pcall(require, package)
  if status == nil then
    error(module)
  else
    return module
  end
end

Safe 'impatient'.enable_profile()

vim.notify = function(_, m, l, o)
  local notify = Safe 'notify'
  if notify then
    vim.notify = notify
    notify(_, m, l, o)
  end
end

Safe 'setup.disable_builtins'
Safe 'setup.options'
Safe 'setup.autocmds'
Safe 'setup.commands'
Safe 'setup.colorscheme'
Safe 'setup.lualine'
Safe 'setup.keymaps'
