local IS_OSX = require('jit').os == 'OSX'

local M = {}

---@type 'catppuccin'
M.colorscheme = 'catppuccin'

---@type nil | 'Copilot'
M.CODE_COMPLETION_AI = 'Copilot'

---@type 'fzf' | 'Telescope'
M.FILE_EXPLORER = 'fzf'

M.USE_AIRLINE = false
M.USE_BUFFERLINE = false
M.USE_LUALINE = true

M.USE_MACOS_OPT_KEYMAPS = IS_OSX

return M
