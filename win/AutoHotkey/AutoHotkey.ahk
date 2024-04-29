#Include "IME.ahk"

SetTitleMatchMode(2)

; #z::Run www.autohotkey.com

Toggle(app) {
  SplitPath(app, &file)
  ErrorLevel := ProcessExist(file)
  if (ErrorLevel != 0)
    if WinActive("ahk_pid" . ErrorLevel)
      WinMinimize("A")
    else
      WinActivate("ahk_pid " ErrorLevel)
  else
    Run(app)
  return
}

ToggleExe(app, exe) {
  ErrorLevel := ProcessExist(app)
  if (ErrorLevel != 0)
    if WinActive("ahk_pid" . ErrorLevel)
      WinMinimize("A")
    else
      WinActivate("ahk_pid " ErrorLevel)
  else
    Run(exe)
  return
}

Activate(app) {
  SplitPath(app, &file)
  ErrorLevel := ProcessExist(file)
  if (ErrorLevel != 0)
      WinActivate("ahk_pid " ErrorLevel)
    else
      Run(app)
  return
}

Activate2(app, cmd) {
  ErrorLevel := ProcessExist(app)
  if (ErrorLevel != 0)
      WinActivate("ahk_pid " ErrorLevel)
    else
      Run(cmd)
  return
}

Activate3(app, cmd, title) {
  ErrorLevel := ProcessExist(app)
  if (ErrorLevel != 0) {
      WinActivate(title)
  } else {
      Run(cmd)
  }
  return
}

; for Outlook
^F9::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenewoutlook")) {
    Activate("C:\Program Files\WindowsApps\Microsoft.OutlookForWindows_1.2023.1011.100_x64__8wekyb3d8bbwe\olk.exe")
    return
  } else {
    Activate("C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")
    return
  }
}

; for Excel
F9::
{
  Activate("C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE")
  return
}

; for Teams
^F12::
{
  ; Activate(EnvGet("APPDATA") . "Local\Microsoft\Teams\current\Teams.exe")
  Activate("C:\Program Files\WindowsApps\MSTeams_23272.2707.2453.769_x86__8wekyb3d8bbwe\ms-teams.exe")
  return
}

; for neovim-qt
F10::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\useneovide")) {
    Activate("neovide.exe")
    return
  } else {
    Activate("nvim-qt.exe")
  ; Activate(EnvGet("USERPROFILE") . "\scoop\apps\goneovim\current\goneovim.exe")
  ; Activate(EnvGet("USERPROFILE") . "\app\fvim\FVim.exe")
    return
  }
}

; for VSCode
; F8::
; {
; Activate3("Code.exe", "C:\Program Files\Microsoft VS Code\Code.exe", "Visual Studio Code")
; return
; }

; for chrome
; F11::
; if FileExist("C:\Program Files\Google\Chrome\Application\chrome.exe")
;   Activate("C:\Program Files\Google\Chrome\Application\chrome.exe")
; else
;   Activate("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
; return

; for Edge
F11::
{
  Activate("C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
  return
}

; for vivaldi
; F11::
; Activate(EnvGet("USERPROFILE") . "\scoop\apps\vivaldi\current\Application\vivaldi.exe")
; return

; for firefox
; F11::
; Activate("C:\Program Files\Mozilla Firefox\firefox.exe")
; return

; for Brave
; F11::
; Activate(EnvGet("USERPROFILE") . "\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe")
; return

; for cmd.exe
; F12::
; Activate(ComSpec)
; return

; for PowerShell.exe
; F12::
; Activate("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
; return

; for pwsh.exe
; F12::
; Activate(EnvGet("USERPROFILE") . "\scoop\shims\pwsh.exe")
; return

; for Terminus
; F12::
; Toggle(EnvGet("USERPROFILE") . "\scoop\apps\terminus\current\Terminus.exe")
; ToggleExe("Terminus.exe", EnvGet("USERPROFILE") . "\AppData\Local\Programs\Terminus\Terminus.exe")
; return

F12::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usewez")) {
    Toggle("C:\Program Files\WezTerm\wezterm-gui.exe")
    return
  } else {
    ToggleExe("WindowsTerminal.exe", EnvGet("USERPROFILE") . "\AppData\Local\Microsoft\WindowsApps\wt.exe")
    return
  }
}

; for Hyper
; F12::
; Toggle(EnvGet("USERPROFILE") . "\AppData\Local\Programs\hyper\Hyper.exe")
; return

; for Fluent Terminal
; F12::
; Activate3("FluentTerminal.App.exe", EnvGet("USERPROFILE") . "\AppData\Local\Microsoft\WindowsApps\flute.exe", "Fluent")
; return
; for Edge
; F11::
; Activate2("MicrosoftEdge.exe", "shell:AppsFolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge")
; return

; for cfiler
^F10::
{
  Activate("C:\Program Files (x86)\cfiler\cfiler.exe")
  return
}

; for slack
^F11::
{
  Activate(EnvGet("USERPROFILE") . "\AppData\Local\slack\slack.exe")
  ; Activate3("slack.exe", "C:\Program Files\slack\slack.exe", "slack")
  ;Activate3("slack.exe", EnvGet("USERPROFILE") . "\AppData\Local\slack\slack.exe", "slack")
  return
}

SC079::IME_SET(1)
SC07B::IME_SET(0)

~Esc::IME_SET(0)
^[::{
  Send "{Esc}"
  IME_SET(0)
}

