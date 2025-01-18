---@type LazyPluginSpec
local Hlslens = {
  -- https://github.com/kevinhwang91/nvim-hlslens
  'kevinhwang91/nvim-hlslens',
  opts = {
    calm_down = true,
    override_lens = function(render, pos_list, nearest, index, rel_index)
      -- local text = ('[%s%s %d/%d]'):format(offset, direction, index, #pos_list)
      -- local text = (' %s%s '):format(offset, direction)

      local offset = math.abs(rel_index) < 2 and '' or math.abs(rel_index)
      local direction = rel_index < 0 and 'N' or (rel_index < 1 and '' or 'n')
      local text = offset .. direction

      text = text == '' and '' or ' ' .. text .. ' '

      local row, col = unpack(pos_list[index])
      local chunks = nearest and { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
        or { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }

      render.setVirt(0, row - 1, col - 1, chunks, nearest)
    end,
  },
  init = function()
    vim.cmd 'highlight link HlSearchLens LineNr'
  end,
}

return Hlslens
