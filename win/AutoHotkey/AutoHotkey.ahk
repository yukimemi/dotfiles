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

^!n::
IfWinExist Untitled - Notepad
  WinActivate
else
  Run Notepad
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

; for Outlook
F9::
Process,Exist,OUTLOOK.EXE
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  Run, "C:/Program Files/Microsoft Office/Office15/OUTLOOK.EXE"
return

; for Excel
^F9::
Process,Exist,excel.exe
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  Run, "C:/Program Files/Microsoft Office/Office15/EXCEL.EXE"
return

; for gvim
F10::
Process,Exist,gvim.exe
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  Run, %USERPROFILE%\app\vim\gvim.exe
return

; for sakura
^F10::
Process,Exist,sakura.exe
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  Run, "C:\Program Files\sakura\sakura.exe"
return

; for chrome
F11::
Process,Exist,chrome.exe
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  if FileExist("C:\Program Files\Google\Chrome\Application\chrome.exe")
    Run, "C:\Program Files\Google\Chrome\Application\chrome.exe"
  else
    Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
return

; for cmd.exe
F12::
Process,Exist,cmd.exe
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  Run, cmd.exe
return

; for cfiler
^F11::
Process,Exist,cfiler.exe
if ErrorLevel <> 0
  WinActivate, ahk_pid %ErrorLevel%
else
  Run, %USERPROFILE%\app\cfiler\cfiler.exe, %USERPROFILE%\app\cfiler, Max
return


; for vim
^[::Send {Esc}{vk1Dsc07B}

; for Windows 8.1
;SendInput !{TAB}
; for persistent script
^!v::
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

RunWait "%USERPROFILE%\app\vim\gvim.exe" "--cmd" "let g:singleton#disable=1" %tempfile%
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

