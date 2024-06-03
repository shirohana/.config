---@type LazyPluginSpec
local Airline = {
  -- https://github.com/vim-airline/vim-airline
  'vim-airline/vim-airline',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'vim-ctrlspace/vim-ctrlspace',
  },
  init = function()
    local g = vim.g
    -- Theme
    g.airline_theme = 'catppuccin'
    g.airline_disabled = true
    -- g.airline_solarized_bg = 'dark'

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

return Airline
