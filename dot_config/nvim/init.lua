require('impatient').enable_profile()
function Safe(package)
  local status, module = pcall(require, package)
  if status == nil then
    error(module)
  else
    return module
  end
end

vim.notify = function(_, m, l, o)
  local notify = Safe 'notify'
  if notify then
    vim.notify = notify
    notify(_, m, l, o)
  end
end
Safe 'config.disable_builtins'
Safe 'config.options'
Safe 'config.autocmds'
Safe 'config.commands'
Safe 'config.keymaps'
Safe 'config.colorscheme'
Safe 'config.lualine_setup'
