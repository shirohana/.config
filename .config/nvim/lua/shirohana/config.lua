local IS_OSX = require('jit').os == 'OSX'

local M = {}

---@type 'catppuccin'
M.colorscheme = 'catppuccin'

---@type nil | 'Codeium' | 'Copilot' | 'Model'
M.CODE_COMPLETION_AI = 'Copilot'

---@type 'fzf' | 'Telescope'
M.FILE_EXPLORER = 'fzf'

M.USE_AIRLINE = true
M.USE_BUFFERLINE = false
M.USE_LSP_SAGA_KEYMAPS = false
M.USE_LUALINE = false

M.USE_MACOS_OPT_KEYMAPS = IS_OSX

return M
