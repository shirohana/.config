require 'shirohana.core'
require 'shirohana.lazy'

vim.cmd('colorscheme ' .. require('shirohana.config').colorscheme)

vim.g.USE_AIRLINE = require('shirohana.config').USE_AIRLINE
