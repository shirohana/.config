require 'env'
require 'keymaps'
require 'abbrs'
require 'theme'

local LAZY_PATH = require('vars').LAZY_PATH

if not vim.loop.fs_stat(LAZY_PATH) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    LAZY_PATH,
  }
end

vim.opt.rtp:prepend(LAZY_PATH)

require('lazy').setup {
  { import = 'plugins' },
  { import = 'plugins.ide' },
  { import = 'plugins.lang' },
}

-- vim.cmd.colorscheme 'catppuccin-macchiato'
