; =============================================================================
; File        : AutoHotkey.ahk
; Author      : yukimemi
; Last Change : 2026/01/01 18:05:14.
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

; =============================================================================
; Helpers
; =============================================================================

; Run PowerShell command and return output
RunPs(script) {
  outFile := EnvGet("TEMP") . "\ahk_ps_" . A_TickCount . ".txt"
  ; Double up quotes for PowerShell command string
  fullCmd := 'powershell -NoProfile -Command "' . script . ' | Out-File -FilePath ' . outFile . ' -Encoding ascii"'
  try {
    RunWait(fullCmd, , "Hide")
  } catch {
    return ""
  }
  result := ""
  if FileExist(outFile) {
    result := Trim(FileRead(outFile), " `t`n`r")
    FileDelete(outFile)
  }
  return result
}

; Get GlazeWM window info (ID|HWND)
GetGlazeWindow(exeName, titleRegex := "") {
  procName := RegExReplace(exeName, "\.exe$", "")
  glazewmPath := "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"

  filter := "$_.processName -eq '" . procName . "' -and $_.title.Length -gt 0"
  if (titleRegex != "") {
    filter .= " -and $_.title -match '" . titleRegex . "'"
  }
  script := "(& '" . glazewmPath . "' query windows | ConvertFrom-Json).data.windows | Where-Object { " . filter . " } | Select-Object -First 1 | ForEach-Object { $_.id + '|' + $_.handle }"
  return RunPs(script)
}

; Focus window via GlazeWM
FocusGlazeWindow(glazeInfo) {
  if (glazeInfo == "")
    return false

  parts := StrSplit(glazeInfo, "|")
  if (parts.Length < 1 || parts[1] == "")
    return false

  glazeId := parts[1]
  glazeHwnd := parts.Length > 1 ? parts[2] : ""
  glazewmPath := "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"

  RunWait('"' . glazewmPath . '" command focus --container-id ' . glazeId, , "Hide")
  Run('"' . glazewmPath . '" command wm-redraw', , "Hide")

  if (glazeHwnd != "") {
    WinActivate("ahk_id " . glazeHwnd)
  }
  return true
}

; Activate window robustly (Local -> GlazeWM -> Run)
ActivateRobust(exeName, runCmd := "", titleParts := "") {
  DetectHiddenWindows(false)

  ; 1. Try local activation
  ids := WinGetList("ahk_exe " . exeName)
  for id in ids {
    title := WinGetTitle("ahk_id " . id)
    if (StrLen(title) == 0)
      continue

    match := (titleParts == "")
    if (!match) {
      for part in StrSplit(titleParts, ",") {
        if InStr(title, Trim(part)) {
          match := true
          break
        }
      }
    }

    if (match) {
      ActivateWindowCommon("ahk_id " . id)
      if WinActive("ahk_id " . id)
        return true
    }
  }

  ; 2. Try GlazeWM activation
  titleRegex := (titleParts != "") ? StrReplace(titleParts, ",", "|") : ""
  if FocusGlazeWindow(GetGlazeWindow(exeName, titleRegex))
    return true

  ; 3. Run if not found
  if (runCmd != "") {
    Run(runCmd)
    return true
  }
  return false
}

ActivateWindowCommon(winTitle) {
  if (WinGetMinMax(winTitle) == -1) {
    WinRestore(winTitle)
  } else {
    WinActivate(winTitle)
  }
  WinShow(winTitle)
}

; =============================================================================
; Public API
; =============================================================================

; Toggle window state (Active -> Minimize, Else -> Activate)
Toggle(app, cmd := "", titleKeywords := "") {
  SplitPath(app, &file)
  exe := (InStr(app, "\") || InStr(app, "/")) ? file : app

  if WinActive("ahk_exe " . exe) {
    currTitle := WinGetTitle("A")
    match := (titleKeywords == "")
    if (!match) {
      for part in StrSplit(titleKeywords, ",") {
        if InStr(currTitle, Trim(part)) {
          match := true
          break
        }
      }
    }
    if (match) {
      WinMinimize("A")
      return
    }
  }
  Activate(app, cmd, titleKeywords)
}

; Activate window robustly (Local -> GlazeWM -> Run)
Activate(app, cmd := "", titleKeywords := "") {
  SplitPath(app, &file)
  exe := (InStr(app, "\") || InStr(app, "/")) ? file : app
  runCmd := (cmd == "" ? app : cmd)

  ; 1. Try specific title first (if provided)
  if (titleKeywords != "" && WinExist(titleKeywords)) {
    ActivateWindowCommon(titleKeywords)
    if WinActive(titleKeywords)
      return
  }

  ActivateRobust(exe, runCmd, titleKeywords)
}

; =============================================================================
; Keybindings
; =============================================================================

; for Outlook
^F9::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenewoutlook")) {
    Activate(EnvGet("LOCALAPPDATA") . "\Microsoft\WindowsApps\olk.exe")
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
  Activate(EnvGet("LOCALAPPDATA") . "\Microsoft\WindowsApps\ms-teams.exe")
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
  Activate("nvim.exe", "wt nvim.cmd", "nvim.cmd")
}

; for Comet
F11::
{
  Activate("comet.exe")
}

F12::
{
  if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usewez")) {
    Toggle("C:\Program Files\WezTerm\wezterm-gui.exe")
    return
  } else if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenu")) {
    Toggle("WindowsTerminal.exe", "nu", "yukimemi-terminal")
    return
  } else {
    Toggle("WindowsTerminal.exe", "wt", "yukimemi-terminal")
    return
  }
}

^F10::
{
  Activate("WindowsTerminal.exe", "yazi", "Yazi,yazi")
}

; for slack
^F11::
{
  Activate(EnvGet("USERPROFILE") . "\AppData\Local\slack\slack.exe")
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
