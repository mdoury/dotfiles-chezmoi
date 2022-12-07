require'impatient'.enable_profile()
function safe(package)
    local status, module = pcall(require, package)
    if not status then
        local n_status, notify = pcall(require, 'notify')
        if not n_status then
            print("🚀 ~ error " .. package, 'error')
        else
            notify("🚀 ~ error " .. package, 'error')
        end
        return nil
    end
    return module
end
vim.notify = function(_, m, l, o)
    local notify = safe 'notify'
    vim.notify = notify
    notify(_, m, l, o)
end
safe 'config.disable_builtins'
safe 'config.options'
safe 'config.autocmds'
safe 'config.commands'
-- safe 'config.mason'
safe 'config.keymaps'
safe 'config.colorscheme'
