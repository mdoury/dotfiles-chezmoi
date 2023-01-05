local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local packer = nil
if packer == nil then
  packer = Safe 'packer'
  packer.init {
    profile = {
      enable = true,
    },
    disable_commands = true,
    display = {
      open_fn = function()
        local result, win, buf = Safe('packer.util').float {
          border = {
            { '╭', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '╮', 'FloatBorder' },
            { '│', 'FloatBorder' },
            { '╯', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '╰', 'FloatBorder' },
            { '│', 'FloatBorder' },
          },
        }
        vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
        return result, win, buf
      end,
    },
  }
end

packer.reset()

packer.bootstrap = packer_bootstrap

return packer
