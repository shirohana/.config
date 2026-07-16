---@brief
---
--- https://projects.eclipse.org/projects/eclipse.jdt.ls
---
--- Language server for Java.
---
--- IMPORTANT: If you want all the features jdtls has to offer, [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
--- is highly recommended. If all you need is diagnostics, completion, imports, gotos and formatting and some code actions
--- you can keep reading here.
---
--- For manual installation you can download precompiled binaries from the
--- [official downloads site](http://download.eclipse.org/jdtls/snapshots/?d)
--- and ensure that the `PATH` variable contains the `bin` directory of the extracted archive.
---
--- ```lua
---   -- init.lua
---   vim.lsp.enable('jdtls')
--- ```
---
--- You can also pass extra custom jvm arguments with the JDTLS_JVM_ARGS environment variable as a space separated list of arguments,
--- that will be converted to multiple --jvm-arg=<param> args when passed to the jdtls script. This will allow for example tweaking
--- the jvm arguments or integration with external tools like lombok:
---
--- ```sh
--- export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/java/lombok.jar"
--- ```
---
--- For automatic installation you can use the following unofficial installers/launchers under your own risk:
---   - [jdtls-launcher](https://github.com/eruizc-dev/jdtls-launcher) (Includes lombok support by default)
---     ```lua
---       -- init.lua
---       vim.lsp.config('jdtls', { cmd = { 'jdtls' } })
---     ```

local function get_jdtls_cache_dir()
  return vim.fn.stdpath('cache') .. '/jdtls'
end

local function get_jdtls_workspace_dir()
  return get_jdtls_cache_dir() .. '/workspace'
end

local function get_jdtls_jvm_args()
  local env = os.getenv('JDTLS_JVM_ARGS')
  local args = {}
  for a in string.gmatch((env or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

-- Multiple JDKs are managed with mise (https://mise.jdx.dev). jdtls itself runs on
-- JDK 21 (current jdtls requires it), while each project is analysed with the JDK
-- matching its declared <java.version> via the `runtimes` list below. mise install
-- paths carry the patch version (e.g. temurin-21.0.11+10.0.LTS) and change on JDK
-- updates, so resolve them at startup with `mise where` instead of hardcoding.
local function mise_bin()
  local found = vim.fn.exepath('mise')
  if found ~= '' then
    return found
  end
  for _, candidate in ipairs({
    '/opt/homebrew/bin/mise',
    '/usr/local/bin/mise',
    vim.fn.expand('~/.local/bin/mise'),
  }) do
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return nil
end

local function java_home(tool)
  local mise = mise_bin()
  if not mise then
    return nil
  end
  local out = vim.fn.system({ mise, 'where', 'java@' .. tool })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  local home = vim.trim(out)
  if home == '' or vim.fn.isdirectory(home .. '/bin') == 0 then
    return nil
  end
  return home
end

-- Eclipse execution-environment id -> mise tool. jdtls selects the runtime whose
-- `name` matches a project's required environment; `default` is the fallback for
-- projects that declare nothing. Add a row here to support another JDK version.
local jdk_runtimes = {
  { name = 'JavaSE-11', tool = 'temurin-11' },
  { name = 'JavaSE-17', tool = 'temurin-17' },
  { name = 'JavaSE-21', tool = 'temurin-21', default = true },
}

local function resolve_runtimes()
  local runtimes = {}
  for _, rt in ipairs(jdk_runtimes) do
    local home = java_home(rt.tool)
    if home then
      table.insert(runtimes, { name = rt.name, path = home, default = rt.default })
    end
  end
  return runtimes
end

local root_markers1 = {
  -- Multi-module projects
  'mvnw', -- Maven
  'gradlew', -- Gradle
  'settings.gradle', -- Gradle
  'settings.gradle.kts', -- Gradle
  -- Use git directory as last resort for multi-module maven projects
  -- In multi-module maven projects it is not really possible to determine what is the parent directory
  -- and what is submodule directory. And jdtls does not break if the parent directory is at higher level than
  -- actual parent pom.xml so propagating all the way to root git directory is fine
  '.git',
}
local root_markers2 = {
  -- Single-module projects
  'build.xml', -- Ant
  'pom.xml', -- Maven
  'build.gradle', -- Gradle
  'build.gradle.kts', -- Gradle
}

---@type vim.lsp.Config
return {
  ---@param dispatchers? vim.lsp.rpc.Dispatchers
  ---@param config vim.lsp.ClientConfig
  cmd = function(dispatchers, config)
    local workspace_dir = get_jdtls_workspace_dir()
    local data_dir = workspace_dir

    if config.root_dir then
      data_dir = data_dir .. '/' .. vim.fn.fnamemodify(config.root_dir, ':p:h:t')
    end

    local config_cmd = {
      'jdtls',
      '-data',
      data_dir,
      get_jdtls_jvm_args(),
    }

    -- Launch the jdtls server on JDK 21 regardless of the shell's JAVA_HOME. The
    -- launcher resolves its own JVM from JAVA_HOME; nvim merges this into (not
    -- replaces) the inherited environment.
    local env = config.cmd_env or {}
    local server_home = java_home('temurin-21')
    if server_home then
      env = vim.tbl_extend('force', env, {
        JAVA_HOME = server_home,
        PATH = server_home .. '/bin:' .. (vim.env.PATH or ''),
      })
    end

    return vim.lsp.rpc.start(config_cmd, dispatchers, {
      cwd = config.cmd_cwd,
      env = env,
      detached = config.detached,
    })
  end,
  filetypes = { 'java' },
  root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2 }
    or vim.list_extend(root_markers1, root_markers2),
  settings = {
    java = {
      configuration = {
        -- Per-project JDK selection: jdtls maps each project's <java.version>
        -- (e.g. 11/17/21 across the mms_* submodules) to the matching runtime.
        runtimes = resolve_runtimes(),
      },
    },
  },
  init_options = {},
}
