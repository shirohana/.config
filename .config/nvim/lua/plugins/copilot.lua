local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local Copilot = {
  Plugins.Copilot,
  init = function()
    vim.g.copilot_filetypes = {
      gitcommit = true,
      markdown = true,
      yaml = true,
      ['neo-tree'] = false,
      [''] = true,
    }
  end,
}

---@type LazyPluginSpec
local LlmNvim = {
  Plugins.LlmNvim,
  opts = {
    api_token = nil,
    -- model = 'codellama/CodeLlama-13b-hf',
    model = 'http://127.0.0.1:8080/completion',
    -- model = '/Users/shirohana/Repositories/codellama/CodeLlama-34b-Instruct/ggml-model-q4_0.gguf',
    lsp = {
      bin_path = vim.api.nvim_call_function('stdpath', { 'data' })
          .. '/mason/bin/llm-ls',
      version = '0.2.0',
    },
    tokens_to_clear = { '<EOT>' },
    fim = {
      enabled = true,
      prefix = '<PRE> ',
      middle = ' <MID>',
      suffix = ' <SUF>',
    },
    -- debounce_ms = 1000,
    context_window = 2048,
    -- tokenizer = {
    --   path = '/Users/shirohana/Repositories/llama.cpp/models/CodeLlama-34b-Instruct/params.json',
    -- },
  },
}

return { Copilot }
