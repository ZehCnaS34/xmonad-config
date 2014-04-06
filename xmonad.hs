import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO



myManageHook = composeAll
               [ className =? "Pidgin"     --> doFloat
               , className =? "Gimp"       --> doFloat
               , className =? "Kopete"     --> doFloat
               , manageDocks
               ]



main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/alex/.xmonad/xmobarrc"
  xmonad $ defaultConfig
        { workspaces = [ "1:doc"
                       , "2:code"
                       , "3:shell"
                       , "4:misc"
                       , "5:misc","6:misc","7:web","8:music", "9:video"]
        , manageHook = myManageHook
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
