local Keys = require('shirohana.core.constants').Keys
local Utils = require 'shirohana.utils'

local keymap = vim.keymap.set

-- Unset Built-ins

keymap('n', ',', '<Nop>')
keymap('n', ';', '<Nop>')
keymap('n', '<F1>', '<Nop>')
keymap('n', 'K', '<Nop>')
keymap('n', 'Q', '<Nop>')
keymap('n', 'ZQ', '<Nop>')
keymap('n', 'ZZ', '<Nop>')
keymap({ 'n', 'v' }, 's', '<Nop>')

-- Generic

keymap({ 'i', 'n', 'v' }, '<C-l>', '<Esc>')

-- Editing

keymap('i', 'OO', '<C-o>O', { desc = 'Insert newline above' })
keymap('n', 'gp', 'o<C-r>"<Esc>', { desc = 'Paste register with newline' })
keymap('n', 'gP', 'O<C-r>"<Esc>', { desc = 'Paste register above with newline' })
keymap('i', '<C-a>', '<C-o>I', { desc = 'Go to start of line' })
keymap('i', '<C-e>', '<C-o>A', { desc = 'Go to end of line' })
keymap('n', 'yp', 'yap<S-}>p', { desc = 'Clone paragraph' })
keymap('n', '<C-j>', '<Cmd>call helper#edit#join_spaceless()<CR>', { desc = 'Join without space' })
keymap('v', 'so<Space>', ":<C-u>'<,'>sort<CR>", { desc = 'Sort lines' })

-- Buffer

keymap('n', Keys['<M-t>'], '<Cmd>enew<CR>', { desc = 'Create new buffer' })
-- todo: https://github.com/neovim/neovim/issues/19624
keymap('n', '<Leader>w', Utils.save_with_formatting, { desc = 'Save buffer' })
keymap('n', '<Leader>W', Utils.save_without_formatting, { desc = 'Save buffer without formatting' })
keymap('n', '<Leader>e', '<Cmd>edit<CR>', { desc = 'Reload buffer' })
keymap('n', '<Leader>q', '<Plug>(close-buffer-keep-layout)', { desc = 'Wipe buffer' })
keymap('n', Keys['<M-[>'] or '<C-[>', '<Cmd>PrevBuffer<CR>', { desc = 'Go to previous buffer' })
keymap('n', Keys['<M-]>'] or '<C-]>', '<Cmd>NextBuffer<CR>', { desc = 'Go to next buffer' })
keymap('n', '<Leader>1', '<Cmd>call helper#buffer#GoNthBuffer(0)<CR>', { desc = 'Go to buffer 1' })
keymap('n', '<Leader>2', '<Cmd>call helper#buffer#GoNthBuffer(1)<CR>', { desc = 'Go to buffer 2' })
keymap('n', '<Leader>3', '<Cmd>call helper#buffer#GoNthBuffer(2)<CR>', { desc = 'Go to buffer 3' })
keymap('n', '<Leader>4', '<Cmd>call helper#buffer#GoNthBuffer(3)<CR>', { desc = 'Go to buffer 4' })
keymap('n', '<Leader>5', '<Cmd>call helper#buffer#GoNthBuffer(4)<CR>', { desc = 'Go to buffer 5' })
keymap('n', '<Leader>6', '<Cmd>call helper#buffer#GoNthBuffer(5)<CR>', { desc = 'Go to buffer 6' })
keymap('n', '<Leader>7', '<Cmd>call helper#buffer#GoNthBuffer(6)<CR>', { desc = 'Go to buffer 7' })
keymap('n', '<Leader>8', '<Cmd>call helper#buffer#GoNthBuffer(7)<CR>', { desc = 'Go to buffer 8' })
keymap('n', '<Leader>9', '<Cmd>call helper#buffer#GoNthBuffer(8)<CR>', { desc = 'Go to buffer 9' })

-- Window

keymap('n', '<Leader>c', '<Cmd>wincmd q<CR>', { desc = 'Close split' })
keymap('n', '<Leader>h', '<Cmd>vsplit<CR>', { desc = 'Create split left' })
keymap('n', '<Leader>j', '<Cmd>split<Bar>wincmd j<CR>', { desc = 'Create split bottom' })
keymap('n', '<Leader>k', '<Cmd>split<CR>', { desc = 'Create split top' })
keymap('n', '<Leader>l', '<Cmd>vsplit<Bar>wincmd l<CR>', { desc = 'Create split right' })
keymap('n', Keys['<M-h>'], '<Cmd>wincmd h<CR>', { desc = 'Go to window in h' })
keymap('n', Keys['<M-j>'], '<Cmd>wincmd j<CR>', { desc = 'Go to window in j' })
keymap('n', Keys['<M-k>'], '<Cmd>wincmd k<CR>', { desc = 'Go to window in k' })
keymap('n', Keys['<M-l>'], '<Cmd>wincmd l<CR>', { desc = 'Go to window in l' })
keymap('n', Keys['<M-H>'], '<Cmd>WindowSwapLeft<CR>', { desc = 'Swap window to h' })
keymap('n', Keys['<M-J>'], '<Cmd>WindowSwapDown<CR>', { desc = 'Swap window to j' })
keymap('n', Keys['<M-K>'], '<Cmd>WindowSwapUp<CR>', { desc = 'Swap window to k' })
keymap('n', Keys['<M-L>'], '<Cmd>WindowSwapRight<CR>', { desc = 'Swap window to l' })
keymap('n', '<Up>', '<Cmd>resize -2<CR>', { desc = 'Shrink window vertically' })
keymap('n', '<Down>', '<Cmd>resize +2<CR>', { desc = 'Grow window vertically' })
keymap('n', '<Left>', '<Cmd>vertical resize -4<CR>', { desc = 'Shrink window horizontally' })
keymap('n', '<Right>', '<Cmd>vertical resize +4<CR>', { desc = 'Grow window horizontally' })
keymap('n', '<Leader>z', '<Cmd>ToggleZoomWindow<CR>', { desc = 'Toggle zoom' })

-- Tabpage

keymap('n', 'st', '<Cmd>tabnew<CR>', { desc = 'Create new tab' })
keymap('n', 'sq', '<Cmd>tabclose<CR>', { desc = 'Clost tab' })
keymap('n', '<Tab>', '<Cmd>tabnext<CR>', { desc = 'Go to next tab' })
keymap('n', '<S-Tab>', '<Cmd>tabprevious<CR>', { desc = 'Go to previous tab' })
keymap('n', Keys['<M-1>'], '<Cmd>1tabn<CR>', { desc = 'Go to tab 1' })
keymap('n', Keys['<M-2>'], '<Cmd>2tabn<CR>', { desc = 'Go to tab 2' })
keymap('n', Keys['<M-3>'], '<Cmd>3tabn<CR>', { desc = 'Go to tab 3' })
keymap('n', Keys['<M-4>'], '<Cmd>4tabn<CR>', { desc = 'Go to tab 4' })
keymap('n', Keys['<M-5>'], '<Cmd>5tabn<CR>', { desc = 'Go to tab 5' })
keymap('n', Keys['<M-6>'], '<Cmd>6tabn<CR>', { desc = 'Go to tab 6' })
keymap('n', Keys['<M-7>'], '<Cmd>7tabn<CR>', { desc = 'Go to tab 7' })
keymap('n', Keys['<M-8>'], '<Cmd>8tabn<CR>', { desc = 'Go to tab 8' })
keymap('n', Keys['<M-9>'], '<Cmd>9tabn<CR>', { desc = 'Go to tab 9' })

-- Selection

keymap('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear hlighlight search' })
-- keymap('n', 'zx', "<Cmd>let @/='\\<'.expand('<cword>').'\\>'<bar>call histadd('search', @/)<bar>set hlsearch<CR>", { desc = 'Highlight current word' })
keymap(
  'n',
  'zx',
  "<Cmd>let @/='\\<'.expand('<cword>').'\\>'<Bar>call histadd('search', @/)<Bar>set hlsearch<Bar>lua require('hlslens').start()<CR>"
)

-- Navigating

keymap('n', '<Bslash>', '<C-o>', { desc = 'Go to previous location' })
keymap('n', '<Bar>', '<C-i>', { desc = 'Go to next location' })
keymap('n', Keys['<M-.>'], ';', { desc = 'Repeat latest f, t, F or T' })
keymap('n', Keys['<M-,>'], ',', { desc = 'Repeat latest f, t, F or T in opposite direction' })

-- Other

keymap('n', 'zl', 'z8l', { desc = 'Scroll right' })
keymap('n', 'zh', 'z8h', { desc = 'Scroll left' })

-- Terminal

keymap('n', '<Leader>t', '<Cmd>terminal<CR>', { desc = 'Create terminal' })
keymap('t', '<C-k>', '<C-Bslash><C-n>', { desc = 'Exit terminal' })
keymap('c', '<C-A>', '<Home>', { desc = 'Go to start of line' })
keymap('c', '<C-E>', '<End>', { desc = 'Go to end of line' })
