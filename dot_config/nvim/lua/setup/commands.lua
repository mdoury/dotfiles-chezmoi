-- Commands
local create_cmd = vim.api.nvim_create_user_command
create_cmd('PackerStatus', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').status()
end, {})
create_cmd('PackerInstall', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').install()
end, {})
create_cmd('PackerUpdate', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').update()
end, {})
create_cmd('PackerSync', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').sync()
end, {})
create_cmd('PackerClean', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').clean()
end, {})
create_cmd('PackerCompile', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').compile()
end, {})
create_cmd('PackerProfile', function()
  vim.cmd [[packadd packer.nvim]]
  Safe('plugins').profile_output()
end, {})
