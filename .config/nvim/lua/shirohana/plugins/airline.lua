---@type LazyPluginSpec
local Airline = {
  -- https://github.com/vim-airline/vim-airline
  'vim-airline/vim-airline',
  enabled = require('shirohana.config').USE_AIRLINE,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'vim-airline/vim-airline-themes',
    'vim-ctrlspace/vim-ctrlspace',
  },
  init = function()
    local g = vim.g

    g.airline_theme = 'solarized'
    g.airline_solarized_bg = 'dark'
    g.airline_powerline_fonts = 1

    g['airline#extensions#tabline#enabled'] = 1

    g['airline#extensions#tabline#show_buffers'] = 1
    g['airline#extensions#tabline#show_close_button'] = 0
    g['airline#extensions#tabline#show_tabs'] = 1

    g['airline#extensions#tabline#switch_buffers_and_tabs'] = 0

    g['airline#extensions#tabline#tab_nr_type'] = 0

    g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
    g['airline#extensions#tabline#fnamemod'] = ':t'
    g['airline#extensions#tabline#fnamecollapse'] = 0
    g['airline#extensions#tabline#fnametruncate'] = 12

    g['airline#extensions#ctrlspace#enabled'] = 1
    g['CtrlSpaceStatuslineFunction'] = 'airline#extensions#ctrlspace#statusline()'
  end,
}

---@type LazyPluginSpec
local AirlineThemes = {
  -- https://github.com/vim-airline/vim-airline-themes
  'vim-airline/vim-airline-themes',
  lazy = true,
}

return { Airline, AirlineThemes }
