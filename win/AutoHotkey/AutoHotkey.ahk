; =============================================================================
; File        : AutoHotkey.ahk
; Author      : yukimemi
; Last Change : 2026/01/01 16:42:40.
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
  if WinActive("ahk_exe " file) {
    WinMinimize("A")
  } else {
    if (!ActivateProcessWindow(file))
      Run(app)
  }
}

ToggleExe(app, exe) {
  if WinActive("ahk_exe " app) {
    WinMinimize("A")
  } else {
    if (!ActivateProcessWindow(app))
      Run(exe)
  }
}

; Helper: Get GlazeWM Info for Terminal with specific title part
GetGlazeWmTerminalInfo(exeName, titleParts) {
  procName := RegExReplace(exeName, "\.exe$", "")
  outFile := EnvGet("TEMP") . "\glazewm_term_" . A_TickCount . ".txt"
  glazewmPath := "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"

  ; PowerShell command: Get all windows for process, then filter by title parts
  ; Note: titleParts is comma separated string. PowerShell needs to check if any part is in title.
  ; We construct a regex for title matching: "part1|part2|part3"
  regexPattern := StrReplace(titleParts, ",", "|")
  regexPattern := StrReplace(regexPattern, " ", "\s*") ; Handle spaces loosely if needed, but simple pipe is good for InStr logic replacement

  psCmd := "(& '" . glazewmPath . "' query windows | ConvertFrom-Json).data.windows | Where-Object { $_.processName -eq '" . procName . "' -and $_.title -match '" . regexPattern . "' } | Select-Object -First 1 | ForEach-Object { $_.id + '|' + $_.handle } | Out-File -FilePath '" . outFile . "' -Encoding ascii"

  fullCmd := 'powershell -NoProfile -Command "' . psCmd . '"'

  try {
    RunWait(fullCmd, , "Hide")
  } catch as err {
  }

  result := ""
  if FileExist(outFile) {
    result := Trim(FileRead(outFile), " `t`n`r")
    FileDelete(outFile)
  }
  return result
}

ToggleTerminalWin(app, cmd, title_parts) {
  ; 1. Try finding in current workspace (Fast)
  if (ProcessExist(app)) {
    for whd in WinGetList("ahk_class CASCADIA_HOSTING_WINDOW_CLASS") {
      this_title := WinGetTitle(whd)
      for current_part in StrSplit(title_parts, ",") {
        current_part := Trim(current_part)
        if InStr(this_title, current_part) {
          if WinActive(whd) {
            WinMinimize("A")
          } else {
            ActivateWindowCommon("ahk_id " whd)
          }
          return
        }
      }
    }
  }

  ; 2. Try finding in other workspaces via GlazeWM (Slower but necessary)
  glazeInfo := GetGlazeWmTerminalInfo(app, title_parts)
  if (StrLen(glazeInfo) > 0) {
    parts := StrSplit(glazeInfo, "|")
    glazeId := parts[1]
    glazeHwnd := parts.Length > 1 ? parts[2] : ""

    glazewmPath := "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"
    runCmd := Format('"{1}" command focus --container-id {2}', glazewmPath, glazeId)
    RunWait(runCmd, , "Hide")
    Run(Format('"{1}" command wm-redraw', glazewmPath), , "Hide")

    if (glazeHwnd != "") {
        WinActivate("ahk_id " . glazeHwnd)
    }
    return
  }

  Run(cmd)
}

ActivateTerminalWin(app, cmd, title_parts) {
  if (ProcessExist(app)) {
    for whd in WinGetList("ahk_class CASCADIA_HOSTING_WINDOW_CLASS") {
      this_title := WinGetTitle(whd)
      ; Split title_parts by comma and check each part
      for current_part in StrSplit(title_parts, ",") {
        current_part := Trim(current_part)
        if InStr(this_title, current_part) {
          ActivateWindowCommon("ahk_id " whd)
          return
        }
      }
    }
  }
  Run(cmd)
}

; Helper: Activate window by HWND or Title
ActivateWindowCommon(winTitle) {
  if (WinGetMinMax(winTitle) == -1) {
    WinRestore(winTitle)
  } else {
    WinActivate(winTitle)
  }
  WinShow(winTitle)
}

; Helper: Get GlazeWM Container Info (ID and Workspace) by process name
GetGlazeWmInfo(exeName) {
  ; Remove .exe extension if present for comparison
  procName := RegExReplace(exeName, "\.exe$", "")
  outFile := EnvGet("TEMP") . "\glazewm_info_" . A_TickCount . ".txt"
  glazewmPath := "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"

  ; PowerShell command to query GlazeWM and output ID and Handle separated by pipe
  psCmd := "(& '" . glazewmPath . "' query windows | ConvertFrom-Json).data.windows | Where-Object { $_.processName -eq '" . procName . "' } | Select-Object -First 1 | ForEach-Object { $_.id + '|' + $_.handle } | Out-File -FilePath '" . outFile . "' -Encoding ascii"

  fullCmd := 'powershell -NoProfile -Command "' . psCmd . '"'

  try {
    RunWait(fullCmd, , "Hide")
  } catch as err {
    ; Silently fail for clean code
  }

  result := ""
  if FileExist(outFile) {
    result := Trim(FileRead(outFile), " `t`n`r")
    FileDelete(outFile)
  }

  return result
}

; Helper: Find and activate window by process name (prioritizing windows with titles)
ActivateProcessWindow(exeName) {
  DetectHiddenWindows(false)

  ; Optimization: Try standard activation first.
  ; If the window is on the current workspace, this is much faster than querying GlazeWM.
  ids := WinGetList("ahk_exe " exeName)
  for this_id in ids {
    if (StrLen(WinGetTitle("ahk_id " this_id)) > 0) {
      ActivateWindowCommon("ahk_id " this_id)
      if WinActive("ahk_id " this_id) {
        return true
      }
      ; If found but didn't activate, it might be on another workspace, so fall through to GlazeWM logic.
      break
    }
  }

  ; Try GlazeWM logic if standard activation failed or no window found (maybe hidden on another workspace?)
  glazeInfo := GetGlazeWmInfo(exeName)
  if (StrLen(glazeInfo) > 0) {
    parts := StrSplit(glazeInfo, "|")
    glazeId := parts[1]
    glazeHwnd := parts.Length > 1 ? parts[2] : ""

    glazewmPath := "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"
    runCmd := Format('"{1}" command focus --container-id {2}', glazewmPath, glazeId)

    ; Execute synchronously to ensure focus happens before redraw
    RunWait(runCmd, , "Hide")
    Run(Format('"{1}" command wm-redraw', glazewmPath), , "Hide")

    ; Try standard activate immediately using the specific HWND from GlazeWM
    if (glazeHwnd != "") {
        WinActivate("ahk_id " . glazeHwnd)
    } else if WinExist("ahk_exe " . exeName) {
        WinActivate()
    }
    return true
  }

  ; Fallback: if GlazeWM didn't help (e.g. not running), try standard logic again purely on what AHK sees
  if (ids.Length > 0) {
     for this_id in ids {
        if (StrLen(WinGetTitle("ahk_id " this_id)) > 0) {
             ActivateWindowCommon("ahk_id " this_id)
             return true
        }
     }
     ActivateWindowCommon("ahk_id " ids[1])
     return true
  }

  return false
}Activate(app) {
  SplitPath(app, &file)
  if (!ActivateProcessWindow(file))
    Run(app)
}

Activate2(app, cmd) {
  if (!ActivateProcessWindow(app))
    Run(cmd)
}

Activate3(app, cmd, title) {
  if WinExist(title) {
    ActivateWindowCommon(title)
    if WinActive(title) {
      return
    }
  }

  if (!ActivateProcessWindow(app))
    Run(cmd)
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
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\notuseexcel")) {
    return
  } else {
    Activate("C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE")
    return
  }
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
; F11::
; {
;   Activate("msedge.exe")
;   return
; }

; for Comet
 F11::
 {
   Activate("comet.exe")
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
  if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usewez")) {
    Toggle("C:\Program Files\WezTerm\wezterm-gui.exe")
    return
  } else if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenu")) {
    ToggleTerminalWin("WindowsTerminal.exe", "nu", "yukimemi-terminal")
    return
  } else {
    ToggleTerminalWin("WindowsTerminal.exe", "wt", "yukimemi-terminal")
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
  ActivateTerminalWin("WindowsTerminal.exe", "yazi", "Yazi,yazi")
}

; for slack
^F11::
{
  Activate(EnvGet("USERPROFILE") . "\AppData\Local\slack\slack.exe")
  ; Activate3("slack.exe", "C:\Program Files\slack\slack.exe", "slack")
  ;Activate3("slack.exe", EnvGet("USERPROFILE") . "\AppData\Local\slack\slack.exe", "slack")
  return
}

; Command Pallet
#HotIf WinActive("ahk_class WinUIDesktopWin32WindowClass ahk_exe Microsoft.CmdPal.UI.exe")

^n::
{
  Send "{Down}"
}

^p::
{
  Send "{Up}"
}

#HotIf

; editprompt
F7::
{
  tempFile := EnvGet("TEMP") . "\editprompt.md"
  if FileExist(tempFile) {
    FileDelete(tempFile)
  }

  ; Run nvim and wait for it to close.
  RunWait('nvim "' . tempFile . '" -c "startinsert"')

  if FileExist(tempFile) {
    prompt := FileRead(tempFile, "UTF-8")
    FileDelete(tempFile)

    A_Clipboard := prompt
    Send("^v")

    ToolTip("✅ Complete send prompt")
    SetTimer(() => ToolTip(), -5000)
  }
}
SC079::IME_SET(1)
SC07B::IME_SET(0)

~Esc::IME_SET(0)
^[::{
  Send "{Esc}"
  IME_SET(0)
}

