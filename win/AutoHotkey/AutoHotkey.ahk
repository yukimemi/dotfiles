; =============================================================================
; File        : AutoHotkey.ahk
; Author      : yukimemi
; Last Change : 2025/06/29 13:54:30.
; =============================================================================

SetTitleMatchMode(2)

#Include "IME.ahk"

LOG_INFO_PATH := "info.log"
LOG_ERROR_PATH := "error.log"

log_info(msg) {
  global LOG_INFO_PATH
  currentDateTime := FormatTime(, "yyyy/MM/dd(ddd) HH:mm:ss")
  FileAppend(currentDateTime " - " msg "`n", LOG_INFO_PATH)
  return
}
log_error(msg) {
  global LOG_ERROR_PATH
  currentDateTime := FormatTime(, "yyyy/MM/dd(ddd) HH:mm:ss")
  FileAppend(currentDateTime " - " msg "`n", LOG_ERROR_PATH)
  return
}

OnError LogError
LogError(exception, mode) {
  log_error("Error on line " exception.Line ": " exception.Message)
  return true
}

Toggle(app) {
  SplitPath(app, &file)
  ErrorLevel := ProcessExist(file)
  if (ErrorLevel != 0)
    if WinActive("ahk_pid " ErrorLevel)
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
    if WinActive("ahk_pid " ErrorLevel)
      WinMinimize("A")
    else
      WinActivate("ahk_pid " ErrorLevel)
  else
    Run(exe)
  return
}

ToggleTerminalWin(app, cmd, title_parts) {
  if (ProcessExist(app)) {
    for whd in WinGetList("ahk_class CASCADIA_HOSTING_WINDOW_CLASS") {
      this_title := WinGetTitle(whd)
      log_info(this_title)
      ; Split title_parts by comma and check each part
      for current_part in StrSplit(title_parts, ",") {
        current_part := Trim(current_part)
        if InStr(this_title, current_part) {
          if WinActive(whd) {
            WinMinimize("A")
          } else {
            WinActivate(whd)
          }
          return
        }
      }
    }
  }
  Run(cmd)
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
    if WinExist(title) {
      WinActivate(title)
    } else {
      Run(cmd)
    }
  } else {
    Run(cmd)
  }
}

; for Outlook
^F9::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenewoutlook")) {
    Activate(EnvGet("LOCALAPPDATA") "\Microsoft\WindowsApps\olk.exe")
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
  Activate(EnvGet("LOCALAPPDATA") "\Microsoft\WindowsApps\ms-teams.exe")
  return
}

; for neovim
F10::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\useneovide")) {
    return Activate("neovide.exe")
  }
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\useneovimqt")) {
    return Activate("nvim-qt.exe")
  }
  Activate3("nvim.exe", "wt nvim.cmd", "nvim.cmd")
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
  Activate("msedge.exe")
  return
}

; for Arc
; F11::
; {
;   Activate("Arc.exe")
;   return
; }

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
    ToggleTerminalWin("WindowsTerminal.exe", "wt pwsh", "yukimemi-pwsh, Gemini")
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
;^F10::
;{
;  Activate(EnvGet("USERPROFILE") . "\app\cfiler\cfiler.exe")
;  return
;}
^F10::
{
  Activate3("yazi.exe", "yazi", "Yazi:")
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

