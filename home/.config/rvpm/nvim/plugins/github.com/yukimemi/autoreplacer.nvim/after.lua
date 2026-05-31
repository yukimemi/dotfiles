-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 15:36:25.
-- =============================================================================

-- Replacement helpers: insert a timestamp between the two captured groups.
local function ts()
  return os.date("%Y%m%d_%H%M%S")
end
local function bump(m)
  return m[1] .. ts() .. m[2]
end
local function last_change(m)
  return m[1] .. os.date("%Y/%m/%d %H:%M:%S") .. "."
end

require("autoreplacer").setup({
  notify = true,
  rules = {
    -- Generic "Last Change : ..." line (was the denops `*` default).
    {
      name = "last-change",
      patterns = { "*" },
      events = { "BufWritePre" },
      range = { head = 15, tail = 15 },
      replace = {
        { pattern = [[(.*Last Change.*: ).*\.$]], with = last_change },
      },
    },
    -- XML / XAML version keys.
    {
      name = "xml-version",
      patterns = { "*.xml", "*.xaml" },
      events = { "BufWritePre" },
      range = { head = 30, tail = 5 },
      replace = {
        -- Any key whose name ends in `version` (covers `version`,
        -- `%{task_file}%_version`, `%{task_name}%_version`, `autobot_version`).
        -- Notes for very magic (\v, auto-prepended): `[^"]*` consumes the literal
        -- braces as plain input, and `<` / `>` are word boundaries — literal angle
        -- brackets must be written `[<]` / `[>]`.
        { pattern = [[\c^(.*key\="[^"]*version"[>])[^<]*([<].*)]], with = bump },
      },
    },
    -- PowerShell.
    {
      name = "ps1",
      patterns = { "*.ps1" },
      events = { "BufWritePre" },
      range = { head = 50, tail = 5 },
      replace = {
        { pattern = [[\c^(\s*.Last Change\s*: ).*\.]],     with = last_change },
        { pattern = [[\c^(.*"version", ")[0-9_]+(".*)]],   with = bump },
        { pattern = [[\c^(.*\$version \= ")[0-9_]+(".*)]], with = bump },
      },
    },
    -- TypeScript.
    {
      name = "ts-version",
      patterns = { "*.ts" },
      events = { "BufWritePre" },
      range = { head = 50, tail = 5 },
      replace = {
        { pattern = [[^(const version \= ")[0-9_]+(";)]], with = bump },
      },
    },
    -- TOML.
    {
      name = "toml-version",
      patterns = { "*.toml" },
      events = { "BufWritePre" },
      range = { head = 55, tail = 5 },
      replace = {
        { pattern = [[^(version \= ["'])[0-9_]+(["'])]], with = bump },
      },
    },
  },
})
