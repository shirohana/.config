local M = {}
local _loaded_clients = {}
local _workspace_files
local _detected_filetypes = {}
local _dont_cache_these_extensions = { 'conf' }
local _opened_files = {} -- Track files opened for each client

--- Plugin configuration with its default values.
M.options = {
  workspace_files = function()
    local gitPath = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    local workspace_files = vim.fn.split(vim.fn.system('git ls-files ' .. gitPath), '\n')
    return workspace_files
  end,
  debug = false,
  default_clients = nil, -- e.g., {'ts_ls', 'lua_ls'} to only populate these by default
  auto_populate = nil,   -- e.g., {'ts_ls'} to auto-populate when these clients attach
}

--- Define workspace-diagnostics setup.
function M.setup(options)
  options = options or {}
  M.options = vim.tbl_deep_extend('keep', options, M.options)

  -- Setup commands
  vim.api.nvim_create_user_command('LspWorkspaceDiagnostics', function(opts)
    local client_names = nil
    if opts.args and opts.args ~= '' then
      client_names = vim.split(opts.args, '%s+')
    end
    M.populate_all_workspace_diagnostics(client_names)
  end, {
    desc = 'Populate diagnostics for the entire workspace',
    nargs = '*',
    complete = function()
      local clients = vim.lsp.get_clients()
      return vim.tbl_map(function(client) return client.name end, clients)
    end
  })

  vim.api.nvim_create_user_command('LspWorkspaceDiagnosticsDebug', function()
    M.options.debug = true
    M.populate_all_workspace_diagnostics()
  end, { desc = 'Populate workspace diagnostics with debug output' })

  -- Setup auto-population on LSP attach
  if M.options.auto_populate and #M.options.auto_populate > 0 then
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and vim.tbl_contains(M.options.auto_populate, client.name) then
          vim.defer_fn(function()
            M.populate_workspace_diagnostics(client, args.buf)
          end, 100) -- Small delay to ensure client is fully attached
        end
      end,
    })
  end

  return M.options
end

local function _get_workspace_files()
  if _workspace_files == nil then
    _workspace_files = M.options.workspace_files() or {}

    _workspace_files = vim.tbl_filter(function(path)
      return vim.fn.filereadable(path) == 1
    end, _workspace_files)

    _workspace_files = vim.tbl_map(function(path)
      return vim.fn.fnamemodify(path, ':p')
    end, _workspace_files)
  end

  return _workspace_files
end

local function _detect_filetype(path)
  local filetype = vim.filetype.match { filename = path }

  -- vim.filetype.match is not guaranteed to work on filename alone
  if not filetype then
    for _, buf in ipairs(vim.fn.getbufinfo()) do
      if vim.fn.fnamemodify(buf.name, ':p') == path then
        return vim.filetype.match { buf = buf.bufnr }
      end
    end

    local bufn = vim.fn.bufadd(path)
    vim.fn.bufload(bufn)

    filetype = vim.filetype.match { buf = bufn }

    vim.api.nvim_buf_delete(bufn, { force = true })
  end

  return filetype
end

local function _get_filetype(path)
  local ext = vim.fn.fnamemodify(path, ':e')

  if rawget(_detected_filetypes, ext) ~= nil then
    return _detected_filetypes[ext]
  end

  local filetype = _detect_filetype(path)

  if not vim.tbl_contains(_dont_cache_these_extensions, ext) then
    _detected_filetypes[ext] = filetype or false
  end

  return filetype
end

local function _populate_workspace_diagnostics(client, bufnr)
  local workspace_files = _get_workspace_files()
  local opened_files = 0

  -- Initialize tracking for this client
  if not _opened_files[client.id] then
    _opened_files[client.id] = {}
  end

  for _, path in ipairs(workspace_files) do
    local filetype = _get_filetype(path)

    if path == vim.api.nvim_buf_get_name(bufnr) then
      goto continue
    end

    if not vim.tbl_contains(client.config.filetypes, filetype) then
      goto continue
    end

    vim.defer_fn(function()
      local params = {
        textDocument = {
          uri = vim.uri_from_fname(path),
          version = 0,
          text = vim.fn.join(vim.fn.readfile(path), '\n'),
          languageId = filetype,
        },
      }
      client:notify('textDocument/didOpen', params)

      -- Track this file for this client
      _opened_files[client.id][path] = {
        uri = vim.uri_from_fname(path),
        filetype = filetype
      }
    end, 0)

    opened_files = opened_files + 1

    ::continue::
  end

  if opened_files > 0 then
    vim.notify(string.format('[workspace-diagnostics] %s: opened %d files', client.name, opened_files),
      vim.log.levels.INFO)
  end
end

function M.populate_workspace_diagnostics(client, bufnr)
  if vim.tbl_contains(_loaded_clients, client.id) then
    return
  end
  table.insert(_loaded_clients, client.id)

  -- Skip GitHub Copilot and other completion-only LSP clients
  if client.name == 'copilot' or client.name == 'GitHub Copilot' then
    return
  end

  if not vim.tbl_get(client.server_capabilities, 'textDocumentSync', 'openClose') then
    return
  end

  if not vim.tbl_get(client.config, 'capabilities', 'textDocument', 'publishDiagnostics') then
    return
  end

  if not vim.tbl_get(client.config, 'filetypes') then
    local msg = '[workspace-diagnostics] '
        .. client.name
        .. ' is skipped: please define `config.filetypes` when setting up the client.'
    vim.api.nvim_echo({ { msg, 'WarningMsg' } }, true, {})
    return
  end

  _populate_workspace_diagnostics(client, bufnr)
end

function M.populate_all_workspace_diagnostics(client_names)
  _loaded_clients = {}
  _workspace_files = nil
  _detected_filetypes = {}

  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    vim.notify('[workspace-diagnostics] No LSP clients attached to current buffer', vim.log.levels.WARN)
    return
  end

  -- Use default_clients if no client_names specified
  client_names = client_names or M.options.default_clients

  -- Filter clients by name if specified
  if client_names then
    if type(client_names) == 'string' then
      client_names = { client_names }
    end

    clients = vim.tbl_filter(function(client)
      return vim.tbl_contains(client_names, client.name)
    end, clients)

    if #clients == 0 then
      vim.notify(string.format('[workspace-diagnostics] No matching clients found for: %s',
        table.concat(client_names, ', ')), vim.log.levels.WARN)
      return
    end
  end

  vim.notify(string.format('[workspace-diagnostics] Processing %d LSP clients...', #clients), vim.log.levels.INFO)

  for _, client in ipairs(clients) do
    M.populate_workspace_diagnostics(client, 0)
  end
end

return M
