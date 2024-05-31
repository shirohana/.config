local Plugins = require('vars').Plugins

-- Lualine https://github.com/nvim-lualine/lualine.nvim
---@type LazyPluginSpec
-- local Lualine = {
--   'nvim-lualine/lualine.nvim',
--   config = true,
-- }

-- Airline https://github.com/vim-airline/vim-airline
---@type LazyPluginSpec
local Airline = {
  'vim-airline/vim-airline',
  dependencies = {
    'vim-airline/vim-airline-themes',
    Plugins.CtrlSpace,
    Plugins.WebDevicons,
  },
  init = function()
    local g = vim.g
    -- Theme
    g.airline_theme = 'solarized'
    g.airline_solarized_bg = 'dark'

    -- Use unicode characters
    g.airline_powerline_fonts = 1

    -- airline # extensions # airline
    g['airline#extensions#tabline#enabled'] = 1

    g['airline#extensions#tabline#show_buffers'] = 1
    g['airline#extensions#tabline#show_close_button'] = 0
    g['airline#extensions#tabline#show_tabs'] = 1

    g['airline#extensions#tabline#switch_buffers_and_tabs'] = 0

    g['airline#extensions#tabline#tab_nr_type'] = 0

    -- Buffer name formmatter
    g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
    g['airline#extensions#tabline#fnamemod'] = ':t'
    g['airline#extensions#tabline#fnamecollapse'] = 0
    g['airline#extensions#tabline#fnametruncate'] = 12

    -- airline # extensions # ctrlspace
    g['airline#extensions#ctrlspace#enabled'] = 1
  end,
}

-- Bufferline https://github.com/akinsho/bufferline.nvim
---@type LazyPluginSpec
--local Bufferline = {
--  'akinsho/bufferline.nvim',
--  version = '*',
--  dependencies = { Plugins.WebDevicons },
--  ---@type bufferline.UserConfig
--  opts = {
--    options = {
--      -- stylua: ignore
--      close_command = function(n) require("mini.bufremove").delete(n, false) end,
--      -- stylua: ignore
--      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
--      diagnostics = 'nvim_lsp',
--      always_show_bufferline = false,
--      diagnostics_indicator = function(_, _, diag)
--        local icons = require('lazyvim.config').icons.diagnostics
--        local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
--          .. (diag.warning and icons.Warn .. diag.warning or '')
--        return vim.trim(ret)
--      end,
--      offsets = {
--        {
--          filetype = 'neo-tree',
--          text = 'Neo-tree',
--          highlight = 'Directory',
--          text_align = 'left',
--        },
--      },
--    },
--  },
--}

return {
  Airline,
  -- Lualine,
}
