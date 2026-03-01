#Requires AutoHotkey v2.0

;-----------------------------------------------------------
; IMEの状態の取得
;   WinTitle="A"    対象Window
;   戻り値          1:ON / 0:OFF / -1:アクティブウィンドウの取得に失敗
;-----------------------------------------------------------
IME_GET(WinTitle:="A")  {
    if !(WinActive(WinTitle))
        return -1

    hwnd := WinGetID
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
    cbSize:=4+4+(PtrSize*6)+16
    stGTI := Buffer(cbSize, 0)
    NumPut("UInt", cbSize, stGTI, 0)   ;	DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", "Uint",0, "Uint", stGTI.Ptr)
                ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd

    return DllCall("SendMessage"
          , "UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",hwnd)
          , "UInt", 0x0283  ;Message : WM_IME_CONTROL
          ,  "Int", 0x0005   ;wParam  : IMC_SETOPENSTATUS
          ,  "Int", 0) ;lParam  : 0 or 1
}

;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle:="A"){
    if !(WinActive(WinTitle))
        return -1

    hwnd := WinGetID
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
    cbSize:=4+4+(PtrSize*6)+16
    stGTI := Buffer(cbSize, 0)
    NumPut("UInt", cbSize, stGTI, 0)   ;	DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", "Uint",0, "Uint", stGTI.Ptr)
                ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd

    return DllCall("SendMessage"
          , "UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",hwnd)
          , "UInt", 0x0283  ;Message : WM_IME_CONTROL
          ,  "Int", 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  "Int", SetSts) ;lParam  : 0 or 1
}
