---@type LazyPluginSpec
local Oil = {
  -- https://github.com/stevearc/oil.nvim
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    use_default_mappings = false,
    view_options = {
      show_hidden = true,
      -- is_always_hidden = function(name)
      --   local ignore = { '.git', 'node_modules', 'vendor' }
      --   for _, v in ipairs(ignore) do
      --     if name:find(v) then
      --       return true
      --     end
      --   end
      --   return false
      -- end,
    },
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['>'] = 'actions.select',
      ['<CR>'] = 'actions.select_vsplit',
      -- ['<C-h>'] = 'actions.select_split',
      -- ['<C-t>'] = 'actions.select_tab',
      ['zp'] = 'actions.preview',
      -- ['<C-c>'] = 'actions.close',
      -- ["<C-l>"] = "actions.refresh",
      ['<'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['gi'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
  },
}

return Oil
