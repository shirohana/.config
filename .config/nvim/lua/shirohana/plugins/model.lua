---@type LazyPluginSpec
local Model = {
  -- https://github.com/gsuuon/model.nvim
  'gsuuon/model.nvim',
  enabled = 'Model' == require('shirohana.config').CODE_COMPLETION_AI,

  -- ft = 'mchat',
  -- -- Don't need these if lazy = false
  -- cmd = { 'M', 'Model', 'Mchat' },
  init = function()
    vim.filetype.add {
      extension = {
        mchat = 'mchat',
      },
    }
  end,

  -- keys = {
  --   { '<C-m>d', ':Mdelete<CR>', mode = 'n' },
  --   { '<C-m>s', ':Mselect<CR>', mode = 'n' },
  --   { '<C-m><space>', ':Mchat<CR>', mode = 'n' },
  -- },

  -- To override defaults add a config field and call setup()

  config = function()
    -- local ollama = require 'model.providers.ollama'
    -- local async = require 'model.util.async'
    -- local curl = require 'model.util.curl'
    -- local mode = require('model').mode
    -- local prompts = require 'model.util.prompts'
    -- local provider_util = require 'model.providers.util'
    -- local util = require 'model.util'
    -- local juice = require 'model.util.juice'

    -- local code = {
    --   provider = {
    --     request_completion = function(handlers, params, options)
    --       local opts = vim.tbl_extend('force', {
    --         url = 'http://localhost:11434',
    --       }, options or {})
    --       local stop_marquee =
    --           juice.handler_marquee_or_notify('ollama: ' .. params.model, handlers.segment, nil, 20)

    --       return curl.stream({
    --         url = opts.url .. '/api/generate',
    --         headers = {
    --           ['Content-Type'] = 'application/json',
    --         },
    --         body = vim.tbl_extend(
    --           'force',
    --           { raw = true },   -- can override raw
    --           params,
    --           { stream = true } -- can't override stream
    --         ),
    --       }, function(data)
    --         stop_marquee()

    --         local item, error = util.json.decode(data)
    --         if item == nil then
    --           util.eshow(error)
    --           return
    --         end

    --         if item.response then
    --           handlers.on_partial(item.response)
    --         end

    --         if item.done then
    --           handlers.on_finish()
    --         end

    --         if item.error then
    --           handlers.on_error(item.error, 'ollama error')
    --         end
    --       end, function(err)
    --         stop_marquee()
    --         handlers.on_error(vim.inspect(err), 'Ollama provider error')
    --       end)
    --     end,
    --   },
    --   mode = mode.APPEND,
    --   params = {
    --     model = 'codellama:70b',
    --     -- temperature = 0.1,    -- Seems to rarely decode EOT if temp is high
    --     -- top_p = 0.9,
    --     -- n_predict = 256,      -- Server seems to be ignoring this?
    --     -- repeat_penalty = 1.2, -- infill really struggles with overgenerating
    --   },
    --   builder = function(input, context)
    --     if input then
    --       return {
    --         prompt = '<|system|>'
    --             .. (context.args or 'You are a helpful assistant')
    --             .. '\n</s>\n<|user|>\n'
    --             .. input
    --             .. '</s>\n<|assistant|>',
    --       }
    --     end
    --     local code = prompts.limit_before_after(context, 30)
    --     return {
    --       prompt = '<PRE> ' .. code.before .. ' <SUF>' .. code.after .. ' <MID>',
    --     }
    --   end,
    -- }

    require('model').setup {
      -- default_prompt = code,
      -- prompts = {
      --   code = {
      --     provider = ollama,
      --     mode = mode.APPEND,
      --   },
      --   }
      -- },
      -- chats = {
      --   code = code,
      -- }
    }
  end,
}

return Model
