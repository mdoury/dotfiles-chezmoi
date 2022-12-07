-- Commands
local create_cmd = vim.api.nvim_create_user_command
create_cmd('PackerStatus', function()
  vim.cmd [[packadd packer.nvim]]
  safe('plugins').status()
end, {})
create_cmd('PackerInstall', function()
  vim.cmd [[packadd packer.nvim]]
  safe('plugins').install()
end, {})
create_cmd('PackerUpdate', function()
  vim.cmd [[packadd packer.nvim]]
  safe('plugins').update()
end, {})
create_cmd('PackerSync', function()
  vim.cmd [[packadd packer.nvim]]
  safe('plugins').sync()
end, {})
create_cmd('PackerClean', function()
  vim.cmd [[packadd packer.nvim]]
  safe('plugins').clean()
end, {})
create_cmd('PackerCompile', function()
  vim.cmd [[packadd packer.nvim]]
  safe('plugins').compile()
end, {})
