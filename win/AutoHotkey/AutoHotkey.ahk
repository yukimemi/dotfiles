; =============================================================================
; File        : AutoHotkey.ahk
; Author      : yukimemi
; Last Change : 2026/02/19 17:47:32.
; =============================================================================

SetTitleMatchMode(2)

#Include "IME.ahk"

; Constants
LOG_INFO_PATH := "info.log"
LOG_ERROR_PATH := "error.log"
GLAZEWM_PATH := EnvGet("USERPROFILE") . "\scoop\shims\glazewm.exe"

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
  ; Use double quotes for the outer string and escape inner double quotes with backtick
  fullCmd := "powershell -NoProfile -Command `"" . script . " | Out-File -FilePath '" . outFile . "' -Encoding ascii`""

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
  global GLAZEWM_PATH
  procName := RegExReplace(exeName, "\.exe$", "")

  ; Run glazewm query directly and capture output to temp file
  outFile := EnvGet("TEMP") . "\ahk_glaze_" . A_TickCount . ".json"
  RunWait('cmd /c ""' . GLAZEWM_PATH . '" query windows > "' . outFile . '""', , "Hide")

  if !FileExist(outFile)
    return ""

  try {
    jsonStr := FileRead(outFile)
    FileDelete(outFile)

    ; Use htmlfile COM object to parse JSON (works on 64-bit AHK)
    sc := ComObject("htmlfile")
    sc.write("<meta http-equiv='X-UA-Compatible' content='IE=edge'>")
    sc.write("<script>var data = " . jsonStr . ";</script>")

    windows := sc.parentWindow.data.data.windows
    len := windows.length

    Loop len {
      i := A_Index - 1
      win := windows.%i%

      ; Check processName (case-insensitive)
      if (StrCompare(win.processName, procName, true) == 0) {

        ; Check title if regex provided
        if (titleRegex != "") {
          if !RegExMatch(win.title, titleRegex)
            continue
        }

        return win.id . "|" . win.handle
      }
    }
  } catch as e {
    log_error("GetGlazeWindow JSON Parse Error: " . e.Message)
  }

  return ""
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
  global GLAZEWM_PATH

  RunWait('"' . GLAZEWM_PATH . '" command focus --container-id ' . glazeId, , "Hide")
  Run('"' . GLAZEWM_PATH . '" command wm-redraw', , "Hide")

  if (glazeHwnd != "") {
    ActivateWindowCommon("ahk_id " . glazeHwnd)
  }
  return true
}

; Activate window robustly (Local -> GlazeWM -> Run)
ActivateRobust(exeName, runCmd := "", titleParts := "") {
  DetectHiddenWindows(false)

  ; 1. Try local activation first (Fast path for visible windows)
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
      Sleep(50) ; Small wait to check if activation actually happened
      if WinActive("ahk_id " . id)
        return true
    }
  }

  ; 2. Try GlazeWM activation (Slow path for hidden/other workspace windows)
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
    ; Force restore if activation doesn't bring it up (for tricky apps like Neovide)
    if (!WinActive(winTitle)) {
      WinRestore(winTitle)
      WinActivate(winTitle)
    }
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

; Outlook (New or Classic)
^F9::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenewoutlook")) {
    Activate(EnvGet("LOCALAPPDATA") . "\Microsoft\WindowsApps\olk.exe")
  } else {
    Activate("C:\ Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")
  }
}

; Excel
F9::
{
  If (!FileExist(EnvGet("USERPROFILE") . "\.autohotkey\notuseexcel")) {
    Activate("C:\ Program Files\Microsoft Office\root\Office16\EXCEL.EXE")
  }
}

; Teams
^F12::
{
  Activate(EnvGet("LOCALAPPDATA") . "\Microsoft\WindowsApps\ms-teams.exe")
}

; Neovim (Neovide, nvim-qt, or Terminal)
F10::
{
  If (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\useneovide")) {
    Activate("neovide.exe")
  } else if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\useneovimqt")) {
    Activate("nvim-qt.exe")
  } else {
    Activate("nvim.exe", "wt nvim.cmd", "nvim.cmd")
  }
}

; Comet
F11::
{
  Activate("comet.exe")
}

; Windows Terminal (Toggle)
F12::
{
  if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usewez")) {
    Toggle("C:\ Program Files\WezTerm\wezterm-gui.exe")
  } else if (FileExist(EnvGet("USERPROFILE") . "\.autohotkey\usenu")) {
    Toggle("WindowsTerminal.exe", "nu", "yukimemi-terminal")
  } else {
    Toggle("WindowsTerminal.exe", "wt", "yukimemi-terminal")
  }
}

; yazi (File Manager)
^F10::
{
  Activate("WindowsTerminal.exe", "yazi", "Yazi,yazi")
}

; Slack
^F11::
{
  Activate(EnvGet("USERPROFILE") . "\AppData\Local\slack\slack.exe")
}

; Command Palette (Microsoft Command Palette)
#HotIf WinActive("ahk_class WinUIDesktopWin32WindowClass ahk_exe Microsoft.CmdPal.UI.exe")
^n:: Send "{Down}"
^p:: Send "{Up}"
#HotIf

; Edit Prompt (Neovim temporary buffer)
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

; ===== CapsLock → Ctrl コンボ方式（AHK v2） =====
#UseHook true
SendMode "Input"
SetCapsLockState "AlwaysOff"   ; 物理CapsLockのトグルを殺す（IME切替の芽を潰す）

; --- CapsLock 単押しは完全に飲み込む（IMEに渡さない） ---
$*CapsLock::return
$*CapsLock up::return
$*SC03A::return
$*SC03A up::return
$*vk14::return
$*vk14 up::return

; --- 必要なコンボだけ Ctrl+? を送る（張り付かない） ---
; ご要望の j / k
CapsLock & j::Send "^j"
CapsLock & k::Send "^k"

; よく使うならここに追加（例：Vim っぽく h/l、編集系など）
CapsLock & h::Send "^h"
CapsLock & l::Send "^l"
CapsLock & u::Send "^u"
CapsLock & i::Send "^i"
CapsLock & w::Send "^w"
CapsLock & s::Send "^s"
CapsLock & t::Send "^t"
CapsLock & n::Send "^n"
CapsLock & Space::Send "^ "
CapsLock & Enter::Send "^{Enter}"
CapsLock & Left::Send "^{Left}"
CapsLock & Right::Send "^{Right}"
CapsLock & Up::Send "^{Up}"
CapsLock & Down::Send "^{Down}"
CapsLock & Backspace::Send "^{Backspace}"

; IME Settings
SC079::IME_SET(1) ; conversion key -> IME ON
SC07B::IME_SET(0) ; non-conversion key -> IME OFF

~Esc::IME_SET(0) ; Esc -> IME OFF

^[::{ ; Ctrl+[ -> Esc and IME OFF
  Send "{Esc}"
  IME_SET(0)
}
