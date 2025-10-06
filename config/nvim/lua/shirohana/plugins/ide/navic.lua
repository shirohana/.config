---@type LazyPluginSpec
local Navic = {
  -- https://github.com/SmiteshP/nvim-navic
  'SmiteshP/nvim-navic',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  opts = {
    depth_limit = 0,
    depth_limit_indicator = '..',
    highlight = true,
    icons = vim.tbl_map(function(v)
      return string.format('%s ', v)
    end, require('shirohana.core.constants').Icons),
    safe_output = true,
    separator = '  ',
  },
  config = function(_, opts)
    local navic = require 'nvim-navic'

    navic.setup(opts)

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
          vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end
      end,
    })
  end,
}

return Navic
