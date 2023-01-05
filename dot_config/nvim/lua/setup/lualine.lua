local lualine = Safe 'lualine'

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local custom_fname = Safe('lualine.components.filename'):extend()
local highlight = Safe 'lualine.highlight'
local default_status_colors = { saved = '#ECEFF4', modified = '#8FBCBB' }

function custom_fname:init(options)
  options.file_status = false
  custom_fname.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      { fg = default_status_colors.saved },
      'filename_status_saved',
      self.options
    ),
    modified = highlight.create_component_highlight_group(
      { fg = default_status_colors.modified, gui = 'bold' },
      'filename_status_modified',
      self.options
    ),
  }
  if self.options.color == nil then
    self.options.color = ''
  end
end

function custom_fname:update_status()
  local data = custom_fname.super.update_status(self)
  data = highlight.component_format_highlight(
    vim.bo.modified and self.status_colors.modified or self.status_colors.saved
  ) .. data
  return data
end

lualine.setup {
  sections = { lualine_c = { custom_fname } },
  options = { theme = 'nord', globalstatus = true },
  { 'diff', source = diff_source },
}
