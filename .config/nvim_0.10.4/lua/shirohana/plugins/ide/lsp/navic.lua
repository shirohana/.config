-- stylua: ignore
local NavicTheme = {
  NavicIconsField         = { fg = '#ed8796', bg = 'NONE' },
  NavicIconsProperty      = { fg = '#ed8796', bg = 'NONE' },
  NavicIconsEvent         = { fg = '#ed8796', bg = 'NONE' },

  NavicText               = { fg = '#8aadf4', bg = 'NONE' },
  NavicIconsEnum          = { fg = '#a6da95', bg = 'NONE' },
  NavicIconsKey           = { fg = '#a6da95', bg = 'NONE' },

  NavicIconsConstant      = { fg = '#eed49f', bg = 'NONE' },
  NavicIconsConstructor   = { fg = '#eed49f', bg = 'NONE' },

  NavicIconsFunction      = { fg = '#c6a0f6', bg = 'NONE' },
  NavicIconsStruct        = { fg = '#c6a0f6', bg = 'NONE' },
  NavicIconsClass         = { fg = '#c6a0f6', bg = 'NONE' },
  NavicIconsModule        = { fg = '#c6a0f6', bg = 'NONE' },
  NavicIconsOperator      = { fg = '#c6a0f6', bg = 'NONE' },

  NavicIconsVariable      = { fg = '#939ab7', bg = 'NONE' },
  NavicIconsFile          = { fg = '#939ab7', bg = 'NONE' },

  NavicIconsMethod        = { fg = '#7dc4e4', bg = 'NONE' },
  NavicIconsEnumMember    = { fg = '#7dc4e4', bg = 'NONE' },

  NavicIconsInterface     = { fg = '#8bd5ca', bg = 'NONE' },
  NavicIconsTypeParameter = { fg = '#8bd5ca', bg = 'NONE' },

  NavicIconsNamespace     = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsPackage       = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsString        = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsNumber        = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsBoolean       = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsArray         = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsObject        = { fg = '#f4dbd6', bg = 'NONE' },
  NavicIconsNull          = { fg = '#f4dbd6', bg = 'NONE' },
  NavicSeparator          = { fg = '#5b6078', bg = 'NONE' },
}

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
  init = function()
    local enable_custom_color = false
    if enable_custom_color then
      for name, opts in pairs(NavicTheme) do
        vim.api.nvim_set_hl(0, name, opts)
      end
    end
  end,
}

return Navic
