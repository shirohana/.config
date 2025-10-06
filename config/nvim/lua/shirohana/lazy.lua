local LAZY_PATH = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(LAZY_PATH) then
  vim.fn.system {
    'git',
    'clone',
    '--branch=stable',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    LAZY_PATH,
  }
end

vim.opt.rtp:prepend(LAZY_PATH)

require('lazy').setup {
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  install = { colorscheme = { 'catppuccin' } },
  spec = {
    { import = 'shirohana.plugins.appearance' },
    { import = 'shirohana.plugins.editor' },
    { import = 'shirohana.plugins.git' },
    { import = 'shirohana.plugins.ide' },
    { import = 'shirohana.plugins.lsp' },
    { import = 'shirohana.plugins.lang' },
  },
}
