-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 00:00:00.
-- =============================================================================

-- PowerShell/cmd polyglot launcher header, parameterized by shell, window
-- visibility, and a trailing command (pause / wait).
local function ps1(shell, hidden, tail)
  local exe = (shell == "pwsh") and "pwsh" or "powershell"
  local hide = hidden and "-WindowStyle Hidden " or ""
  local cmdflag = (shell == "pwsh") and "-Command " or ""
  return "@set __SCRIPTPATH=%~f0&@"
    .. exe
    .. " -NoProfile -ExecutionPolicy ByPass -InputFormat None "
    .. hide
    .. cmdflag
    .. [["$s=[scriptblock]::create((gc -enc utf8 -li \"%~f0\"|?{$_.readcount -gt 2})-join\"`n\");&$s" %*]]
    .. tail
    .. "\n@exit /b %errorlevel%\n"
end

local PAUSE = "&@pause"
local WAIT = "&@ping -n 30 localhost > nul"

-- name -> { shell, hidden, tail } for the ps1 launchers (all written to ../cmd).
local PS1_LAUNCHERS = {
  { "defaultcmd", "powershell", false, "" },
  { "pausecmd", "powershell", false, PAUSE },
  { "waitcmd", "powershell", false, WAIT },
  { "defaultcmdhidden", "powershell", true, "" },
  { "waitcmdhidden", "powershell", true, WAIT },
  { "defaultcmdpwsh", "pwsh", false, "" },
  { "pausecmdpwsh", "pwsh", false, PAUSE },
  { "waitcmdpwsh", "pwsh", false, WAIT },
  { "defaultcmdhiddenpwsh", "pwsh", true, "" },
  { "waitcmdhiddenpwsh", "pwsh", true, WAIT },
}

local ps1_generators = {}
for _, l in ipairs(PS1_LAUNCHERS) do
  ps1_generators[#ps1_generators + 1] = {
    name = l[1],
    dst = "../cmd",
    ext = ".cmd",
    header = ps1(l[2], l[3], l[4]),
  }
end

-- JScript/cmd polyglot launcher.
local function js(tail)
  return "@set @junk=1 /*\n@cscript //nologo //e:jscript \"%~f0\" %*\n"
    .. (tail ~= "" and tail .. "\n" or "")
    .. "@exit /b %errorlevel%\n*/\n"
end

require("ahdr").setup({
  generators = {
    ps1 = ps1_generators,
    javascript = {
      { name = "default", dst = "../cmd", ext = ".cmd", header = js("") },
      { name = "pausecmd", dst = "../cmd", ext = ".cmd", header = js("@pause") },
      { name = "waitcmd", dst = "../cmd", ext = ".cmd", header = js("@ping -n 30 localhost > nul") },
    },
    dosbatch = {
      {
        name = "admincmd",
        suffix = "_a",
        dst = "../cmd",
        ext = ".bat",
        header = [[
@openfiles > nul 2>&1
@if %errorlevel% equ 0 goto :ALREADY_ADMIN_PRIVILEGE
@powershell.exe -Command Start-Process \'%~f0\' %* -verb runas
@exit /b %errorlevel%
:ALREADY_ADMIN_PRIVILEGE
]],
      },
    },
  },
})
