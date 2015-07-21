-- ~/.xmonad/xmonad.hs
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run

main = do
  myStatusBar <- spawnPipe "xmobar"
  xmonad defaultConfig {
    modMask = myModMask,
    layoutHook = myLayoutHook,
    manageHook = myManageHook,
    logHook = myLogHook myStatusBar
  }

myModMask = mod4Mask

myLayoutHook = avoidStruts $ layoutHook defaultConfig
myManageHook = manageDocks <+> manageHook defaultConfig

myLogHook h = dynamicLogWithPP xmobarPP {
  ppOutput = hPutStrLn h
}
