require 'shirohana.core'
require 'shirohana.lazy'

vim.g.USE_AIRLINE = require('shirohana.config').USE_AIRLINE

local function colorscheme_exists(name)
  local success, _ = pcall(vim.cmd, 'colorscheme ' .. name)
  return success
end

if colorscheme_exists(require('shirohana.config').colorscheme) then
  vim.cmd('colorscheme ' .. require('shirohana.config').colorscheme)
end
