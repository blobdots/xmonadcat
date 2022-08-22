import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.StackSet
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageDocks

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ docks $ gigaConfig

gigaConfig = def
     { modMask            = mod4Mask
     , layoutHook         = gigaLayout
     , startupHook        = gigaStart
     , normalBorderColor  = "#9399b2"
     , focusedBorderColor = "#cba6f7"
     , XMonad.workspaces  = gigaWorkspaces
     }

   `additionalKeysP`
     [ ("M-C-s"       , unGrab *> spawn "scrot -s")
     , ("M-S-b"       , spawn "firefox"           )
     , ("M-S-<Return>", spawn "alacritty"         )
     , ("M-<Return>"  , windows swapMaster        )
     , ("M-p"         , spawn "rofi -show run"    )
     , ("M-S-t"       , spawn "thunar"            )
     ]

gigaLayout = avoidStruts $ tiled ||| Mirror tiled ||| noBorders Full ||| threeCol
  where
    threeCol = spacing 10 $ magnifiercz' 1.5 $ ThreeColMid nmaster delta ratio
    tiled    = spacing 10 $ Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100

gigaStart = do
  spawnOnce "feh --bg-fill ~/Pictures/Wallpapers/Waves.png"
  spawnOnce "picom"
  spawn "polylaunch.sh"

gigaWorkspaces = ["1","2","3","4","5","6","7","8","9"]
