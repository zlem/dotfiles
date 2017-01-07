import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/zlem/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
				, terminal = "urxvt"
        , layoutHook =  avoidStruts $ smartBorders $ layoutHook defaultConfig
				, startupHook = setWMName "LG3D"
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 200
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
				, ((0, 0x1008ff41), spawn "urxvtcd")
        , ((0, xK_Print), spawn "scrot")
        ]

