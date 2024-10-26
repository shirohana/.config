require 'shirohana.core'
require 'shirohana.lazy'
-- require 'shirohana.ai'

vim.cmd('colorscheme ' .. require('shirohana.config').colorscheme)

vim.g.USE_AIRLINE = require('shirohana.config').USE_AIRLINE
