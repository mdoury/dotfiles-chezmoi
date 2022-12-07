local map = vim.api.nvim_set_keymap
local create_cmd = vim.api.nvim_create_user_command

create_cmd('BreakpointToggle', function()
  safe('dap').toggle_breakpoint()
end, {})
create_cmd('Debug', function()
  safe('dap').continue()
end, {})
create_cmd('DapREPL', function()
  safe('dap').repl.open()
end, {})

map('n', '<F5>', '', {
  callback = function()
    safe('dap').continue()
  end,
  noremap = true,
})
map('n', '<F10>', '', {
  callback = function()
    safe('dap').step_over()
  end,
  noremap = true,
})
map('n', '<F11>', '', {
  callback = function()
    safe('dap').step_into()
  end,
  noremap = true,
})
map('n', '<F12>', '', {
  callback = function()
    safe('dap').step_out()
  end,
  noremap = true,
})
