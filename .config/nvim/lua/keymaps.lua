local keymap = vim.keymap.set

local has_local_prettier = nil

local function detect_local_prettier()
  if has_local_prettier == nil then
    local script = [[
      const path = require('path');
      const root = path.parse(process.cwd()).root;
      let cpath = process.cwd(), max = 10, meta;
      while (cpath !== root && max --> 0) {
        try {
          meta = require(path.join(cpath, 'package.json'));
          break;
        } catch (e) {}
        cpath = path.dirname(cpath);
      }
      process.stdout.write(meta && 'prettier' in (meta?.devDependencies || {}) ? 'true' : 'false');
    ]]
    local cmd = 'node <<EOF\n' .. script .. '\nEOF'
    local handle = io.popen(cmd)
    local result = nil
    if handle then
      result = handle:read '*a'
      handle:close()
    end
    has_local_prettier = result == 'true'
  end
  return has_local_prettier
end

local function save_with_formatting()
  local should_format = true
  if
      vim.tbl_contains(
        { 'javascript', 'typescript', 'typescriptreact' },
        vim.bo.filetype
      )
  then
    should_format = detect_local_prettier()
  end
  if should_format then
    vim.lsp.buf.format { timeout_ms = 5000 }
  end
  vim.cmd 'write'
end

local function save_without_formatting()
  local strip_ws_enabled = vim.b.strip_whitespace_on_save
  if strip_ws_enabled then
    vim.cmd 'DisableStripWhitespaceOnSave'
  end
  vim.cmd 'write'
  if strip_ws_enabled then
    vim.cmd 'EnableStripWhitespaceOnSave'
  end
end

-- ======== Defaults ========
keymap('n', ',', '<Nop>')
keymap('n', ';', '<Nop>')
keymap('n', 'K', '<Nop>')
keymap('n', 'Q', '<Nop>')
keymap('n', 'ZQ', '<Nop>')
keymap('n', 'ZZ', '<Nop>')
keymap({ 'n', 'v' }, 's', '<Nop>')
keymap('v', 's', '<Nop>')
keymap('n', '<F1>', '<Nop>')

-- ======== Generic ========
-- Better <Esc> (map 'n' for errorbells)
keymap({ 'i', 'n', 'v' }, '<C-L>', '<Esc>')
-- Cancel highlight search
keymap('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>')
-- Highlight search on current word
-- stylua: ignore
keymap('n', 'zx',
  "<Cmd>let @/='\\<'.expand('<cword>').'\\>'<Bar>call histadd('search', @/)<Bar>set hlsearch<Bar>lua require('hlslens').start()<CR>")

-- ======== Moving ========
-- Move screen horizontally
keymap('n', 'zl', 'z8l')
keymap('n', 'zh', 'z8h')
-- Jump to older/newer cursor position
keymap('n', '<Bslash>', '<C-o>')
keymap('n', '<Bar>', '<C-i>')
-- Search left/right of previous inline-jump by <Opt-,> and <Opt-.>
keymap('n', '≤', ',')
keymap('n', '≥', ';')
-- keymap('n', 'ss', '/\\c')
keymap('n', 'ss', '/')

-- ======== Editing ========
-- Insert one line above in INSERT
keymap('i', 'OO', '<C-O>O')
-- Paste register in newline
keymap('n', 'gp', 'o<C-R>"<Esc>')
keymap('n', 'gP', 'O<C-R>"<Esc>')
-- Go to start/end of line in INSERT
keymap('i', '<C-A>', '<C-O>I')
keymap('i', '<C-E>', '<C-O>A')
-- Clone paragraph
keymap('n', 'yp', 'yap<S-}>p')
-- Join line without space
keymap('n', '<C-J>', '<Cmd>call helper#edit#join_spaceless()<CR>')
-- Sort lines
keymap('v', 'so<Space>', ":<C-U>'<,'>sort<CR>")

-- ======== Command ========
-- Go to start/end of current command
keymap('c', '<C-A>', '<Home>')
keymap('c', '<C-E>', '<End>')

-- ======== Buffer ========
-- Create new buffer, using <Opt-t>
keymap('n', '†', '<Cmd>enew<CR>')
-- Save buffer
-- todo: https://github.com/neovim/neovim/issues/19624
keymap('n', '<Leader>w', save_with_formatting)
-- Save buffer without formatting
keymap('n', '<Leader>W', save_without_formatting)
-- Reload buffer
keymap('n', '<Leader>e', '<Cmd>edit<CR>')
-- Wipe buffer
keymap('n', '<Leader>q', '<Plug>(close-buffer-keep-layout)')
-- Save & wipe buffer
-- keymap('n', '<Leader>W', ':<C-u>write<Bar>exec "normal \\<Plug>(close-buffer-keep-layout)"<CR>')
-- Buffer navigating, using <Opt-[> & <Opt-]>
keymap('n', '“', '<Cmd>PrevBuffer<CR>')
keymap('n', '‘', '<Cmd>NextBuffer<CR>')
-- Buffer navigating with index
keymap('n', '<Leader>1', '<Cmd>call helper#buffer#GoNthBuffer(0)<CR>')
keymap('n', '<Leader>2', '<Cmd>call helper#buffer#GoNthBuffer(1)<CR>')
keymap('n', '<Leader>3', '<Cmd>call helper#buffer#GoNthBuffer(2)<CR>')
keymap('n', '<Leader>4', '<Cmd>call helper#buffer#GoNthBuffer(3)<CR>')
keymap('n', '<Leader>5', '<Cmd>call helper#buffer#GoNthBuffer(4)<CR>')
keymap('n', '<Leader>6', '<Cmd>call helper#buffer#GoNthBuffer(5)<CR>')
keymap('n', '<Leader>7', '<Cmd>call helper#buffer#GoNthBuffer(6)<CR>')
keymap('n', '<Leader>8', '<Cmd>call helper#buffer#GoNthBuffer(7)<CR>')
keymap('n', '<Leader>9', '<Cmd>call helper#buffer#GoNthBuffer(8)<CR>')

-- ======== Window ========
-- Create split, using `<Space>[hjkl]`
keymap('n', '<Leader>h', '<Cmd>vsplit<CR>')
keymap('n', '<Leader>j', '<Cmd>split<Bar>wincmd j<CR>')
keymap('n', '<Leader>k', '<Cmd>split<CR>')
keymap('n', '<Leader>l', '<Cmd>vsplit<Bar>wincmd l<CR>')
-- Close current split, using `<Space>c`
keymap('n', '<Leader>c', '<Cmd>wincmd q<CR>')
-- Window navigating, using <Opt-[hjkl]>
keymap('n', '˙', '<Cmd>wincmd h<CR>')
keymap('n', '∆', '<Cmd>wincmd j<CR>')
keymap('n', '˚', '<Cmd>wincmd k<CR>')
keymap('n', '¬', '<Cmd>wincmd l<CR>')
-- Buffer swap, using <Opt-Shift-[hjkl]>
keymap('n', 'Ó', '<Cmd>WindowSwapLeft<CR>')
keymap('n', 'Ô', '<Cmd>WindowSwapDown<CR>')
keymap('n', '', '<Cmd>WindowSwapUp<CR>')
keymap('n', 'Ò', '<Cmd>WindowSwapRight<CR>')
-- Window resize, using arrow keys
keymap('n', '<Up>', '<Cmd>resize -2<CR>')
keymap('n', '<Down>', '<Cmd>resize +2<CR>')
keymap('n', '<Left>', '<Cmd>vertical resize -4<CR>')
keymap('n', '<Right>', '<Cmd>vertical resize +4<CR>')
-- Toggle zoom
keymap('n', '<Leader>z', '<Cmd>ToggleZoomWindow<CR>')
-- Enter terminal
keymap('n', '<Leader>t', '<Cmd>terminal<CR>')

-- ======== Tabpage ========
-- Create new tab, using st or <Opt-Shift-t>
keymap('n', 'st', '<Cmd>tabnew<CR>')
keymap('n', 'ˇ', '<Cmd>tabnew<CR>')
-- Close tab, using sq or <Opt-Shift-q>
keymap('n', 'sq', '<Cmd>tabclose<CR>')
keymap('n', 'Œ', '<Cmd>tabclose<CR>')
-- Switch to next/prev tab, using <Opt-Shift-[> & <Opt-Shift-]>
keymap('n', '’', '<Cmd>tabnext<CR>')
keymap('n', '”', '<Cmd>tabprevious<CR>')
-- Switch to next/prev tab, using <Tab> & <S-Tab>
keymap('n', '<Tab>', '<Cmd>tabnext<CR>')
keymap('n', '<S-Tab>', '<Cmd>tabprevious<CR>')
-- Tab navigating with index, using <Opt-[1-9]>
keymap('n', '¡', '<Cmd>1tabn<CR>')
keymap('n', '™', '<Cmd>2tabn<CR>')
keymap('n', '£', '<Cmd>3tabn<CR>')
keymap('n', '¢', '<Cmd>4tabn<CR>')
keymap('n', '∞', '<Cmd>5tabn<CR>')
keymap('n', '§', '<Cmd>6tabn<CR>')
keymap('n', '¶', '<Cmd>7tabn<CR>')
keymap('n', '•', '<Cmd>8tabn<CR>')
keymap('n', 'ª', '<Cmd>9tabn<CR>')

-- ======== Quickfix ========
vim.cmd [[
augroup HanaQuickFix
  autocmd!
  " execute :colder with `<` & `>`
  autocmd FileType qf nnoremap <buffer> < <Cmd>colder<CR>
  autocmd FileType qf nnoremap <buffer> > <Cmd>cnewer<CR>
augroup END
]]

-- ======== Terminal ========
-- Enter -- NORMAL --
keymap('t', '<C-k>', '<C-\\><C-n>')
-- Clear Scrollback
-- autocmd MyAutoCmd TermOpen * nnoremap <buffer> <silent> <C-k> :<C-u>ClearScrollback<CR>
