---@type LazyPluginSpec
local Conform = {
  -- https://github.com/stevearc/conform.nvim
  'stevearc/conform.nvim',
  opts = {
    format_on_save = false,
    formatters_by_ft = {
      ['javascript'] = { 'eslint_d', 'prettierd' },
      ['typescript'] = { 'eslint_d', 'prettierd' },
      ['svelte'] = { 'eslint_d' },
      -- ['lua'] = { 'stylua' },
      -- ['python'] = { 'black' },
      -- ['sh'] = { 'shfmt' },
      -- ['yaml'] = { 'yamlfmt' },
    },
  },
}

return Conform
