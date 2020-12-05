; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

#z::Run www.autohotkey.com

Toggle(app) {
  SplitPath, app, file
  Process, Exist, %file%
  if ErrorLevel <> 0
    if WinActive("ahk_pid" . ErrorLevel)
      WinMinimize, A
    else
      WinActivate, ahk_pid %ErrorLevel%
  else
    Run, %app%
  return
}

Activate(app) {
  SplitPath, app, file
  Process, Exist, %file%
  if ErrorLevel <> 0
      WinActivate, ahk_pid %ErrorLevel%
    else
      Run, %app%
  return
}

Activate2(app, cmd) {
  Process, Exist, %app%
  if ErrorLevel <> 0
      WinActivate, ahk_pid %ErrorLevel%
    else
      Run, %cmd%
  return
}

Activate3(app, cmd, title) {
  Process, Exist, %app%
  if (ErrorLevel <> 0) {
      SetTitleMatchMode, 2
      WinActivate, %title%
      SetTitleMatchMode, 1
  } else {
      Run, %cmd%
  }
  return
}

; for Outlook
^F9::
Activate("C:\Program Files (x86)\Microsoft Office\Office16\OUTLOOK.EXE")
return

; for Excel
F9::
Activate("C:\Program Files (x86)\Microsoft Office\Office16\EXCEL.EXE")
return

; for Teams
^F12::
Activate(APPDATA . "Local\Microsoft\Teams\current\Teams.exe")
return

; for gvim
F10::
Activate3("gvim.exe", "C:\tools\vim\vim82\gvim.exe", "GVIM")
return
; for neovim
; F10::
; Activate(USERPROFILE . "\scoop\shims\nvim.exe")
; return

; for sakura
; ^F10::
; Activate("C:\Program Files (x86)\sakura\sakura.exe")
; return

; for chrome
F11::
if FileExist("C:\Program Files\Google\Chrome\Application\chrome.exe")
  Activate("C:\Program Files\Google\Chrome\Application\chrome.exe")
else
  Activate("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
return

; for Edge
; F11::
; Activate("C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
; return

; for vivaldi
; F11::
; Activate(USERPROFILE . "\scoop\apps\vivaldi\current\Application\vivaldi.exe")
; return

; for firefox
; F11::
; Activate("C:\Program Files\Mozilla Firefox\firefox.exe")
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
; Activate(USERPROFILE . "\scoop\shims\pwsh.exe")
; return

; for Terminus
; F12::
; Toggle(USERPROFILE . "\scoop\apps\terminus\current\Terminus.exe")
; return

; for wezterm
; F12::
; Toggle(USERPROFILE . "\app\WezTerm\wezterm.exe")
; return

; for Hyper
; F12::
; Activate(USERPROFILE . "\AppData\Local\hyper\Hyper.exe")
; return

; for terminus
; F12::
; Activate2("Terminus.exe", USERPROFILE . "\app\terminus\terminus-portable.exe")
; return

; for Fluent Terminal
F12::
Activate3("FluentTerminal.App.exe", USERPROFILE . "\AppData\Local\Microsoft\WindowsApps\flute.exe", "Fluent")
return


; for Edge
; F11::
; Activate2("MicrosoftEdge.exe", "shell:AppsFolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge")
; return

; for cfiler
; ^F11::
; Activate(USERPROFILE . "\app\cfiler\cfiler.exe")
; return

; for slack
^F11::
; Activate("C:\Program Files\Slack\Slack.exe")
Activate3("Slack.exe", "C:\Program Files\Slack\Slack.exe", "Slack")
return

; for AFxW
; F11::
; Activate(USERPROFILE . "\app\afxw\AFXW.EXE")
; return

; for NynFi
; F11::
; Activate(USERPROFILE . "\app\nyanfi64\NyanFi.exe")
; return


; for vim
^[::Send {Esc}{vk1Dsc07B}

; for Windows 8.1
;SendInput !{TAB}
; for persistent script
; ^!v::
^F10::
target_wid := WinExist("A")
saveclip := Clipboard
Clipboard := ""
SendInput ^c
ClipWait, 0.1
if (Clipboard = "")
{
    SendInput ^a^c
    ClipWait, 0.1
}
tempfile := A_Temp . "\ahkexted.eml"
file := FileOpen(tempfile, "w")
if !IsObject(file)
{
    MsgBox Cannot open "%tempfile%" for writing.
    return
}
file.Write(Clipboard)
file.Close()
Clipboard := saveclip

RunWait "%USERPROFILE%\scoop\apps\vim-kaoriya\current\gvim.exe" "--cmd" "let g:singleton#disable=1" %tempfile%
;RunWait "%USERPROFILE%\app\Atom\atom.exe" %tempfile%

file := FileOpen(tempfile, "r")
if !IsObject(file)
{
    MsgBox Cannot open "%tempfile%" for reading.
    return
}
Clipboard := file.Read()
file.Close()
FileDelete, %tempfile%

WinActivate ahk_id %target_wid%
WinWaitActive, ahk_id %target_wid%, , 2
if (Clipboard = "")
    SendInput {DEL}
else
    SendInput ^v
return

