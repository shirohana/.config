---@type LazyPluginSpec
local WorkspaceDiagnostics = {
  -- https://github.com/artemave/workspace-diagnostics.nvim
  'artemave/workspace-diagnostics.nvim',
  -- event = 'LspAttach',
  enabled = false,
  lazy = true,
  opts = {
    -- Workspace files function (same as your current setup)
    workspace_files = function()
      local gitPath = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        return {}
      end
      local workspace_files = vim.fn.split(vim.fn.system('git ls-files ' .. gitPath), '\n')
      return workspace_files
    end,
  },
  config = function(_, opts)
    local workspace_diagnostics = require 'workspace-diagnostics'
    workspace_diagnostics.setup(opts)

    -- Setup auto-population for specific clients (like your current ts_ls setup)
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'ts_ls' then
          -- Small delay to ensure client is fully attached
          vim.defer_fn(function()
            workspace_diagnostics.populate_workspace_diagnostics(client, args.buf)
          end, 100)
        end
      end,
    })

    -- Create user commands
    vim.api.nvim_create_user_command('LspWorkspaceDiagnostics', function(opts)
      local client_names = nil
      if opts.args and opts.args ~= '' then
        client_names = vim.split(opts.args, '%s+')
      end

      local clients = vim.lsp.get_clients { bufnr = 0 }

      -- Filter clients by name if specified
      if client_names then
        clients = vim.tbl_filter(function(client)
          return vim.tbl_contains(client_names, client.name)
        end, clients)
      end

      for _, client in ipairs(clients) do
        workspace_diagnostics.populate_workspace_diagnostics(client, 0)
      end
    end, {
      desc = 'Populate diagnostics for workspace (optionally filter by client names)',
      nargs = '*',
      complete = function()
        local clients = vim.lsp.get_clients()
        return vim.tbl_map(function(client)
          return client.name
        end, clients)
      end,
    })
  end,
}

return WorkspaceDiagnostics
