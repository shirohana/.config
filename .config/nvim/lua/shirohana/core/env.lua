local g = vim.g
local opt = vim.opt

g.loaded_perl_provider = 0
g.netrw_liststyle = 3

-- Global Map Leader

g.mapleader = ' '
g.maplocalleader = ';'

-- Editor Config

opt.fileencodings = 'ucs-bom,utf-8,shift_jis,default,latin1'
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true

-- Behavior

opt.mouse = nil
opt.hidden = true
opt.belloff = nil
opt.errorbells = true
opt.backspace = 'indent,eol,start'

-- Appearance

opt.background = 'dark'
opt.colorcolumn = '80,100,120'
opt.cursorline = true
opt.guicursor = nil
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.wrap = false

vim.cmd [[
augroup HanaEnv
  autocmd!
  autocmd TermOpen * setlocal scrolloff=0
  autocmd FileType dockerfile set iskeyword+=-
  autocmd FileType html set iskeyword+=-
  autocmd FileType javascript set iskeyword+=$,-
  autocmd FileType plantuml set iskeyword+=$
  autocmd FileType svelte set iskeyword+=$,-
  autocmd FileType typescript set iskeyword+=#,$,-
  autocmd FileType typescriptreact set iskeyword+=$,-
  autocmd BufRead,BufNewFile docker-compose*.yml set filetype=yaml.docker-compose
  autocmd BufRead,BufNewFile *.env.* set filetype=sh
  autocmd BufRead,BufNewFile * if !did_filetype() && getline(1) =~# '@startuml\>'| setfiletype plantuml | endif
  autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml,*.iuml set filetype=plantuml
augroup END
]]
