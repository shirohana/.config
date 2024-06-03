local LAZY_PATH = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(LAZY_PATH) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    LAZY_PATH,
  })
end

vim.opt.rtp:prepend(LAZY_PATH)

require('lazy').setup {
  { import = 'shirohana.plugins' },
}
