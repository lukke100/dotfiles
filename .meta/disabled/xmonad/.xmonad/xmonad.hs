import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Layout.GridVariants
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

borderSelectBkg :: String
borderSelectBkg = "#d79fcf"

borderSelectTxt :: String
borderSelectTxt = "#000000"

barPath :: String
barPath = "xmobar ~/.xmonad/xmobar.rc"

layouts = spacing 17 (Tall 1 (4/100) $ 56/100)
      ||| spacing 17 (Grid $ 4/3)
      ||| noBorders Full

main :: IO ()
main = statusBar barPath barFmt toggleStrutsKey conf >>= xmonad

barFmt :: PP
barFmt = xmobarPP
  { ppCurrent = xmobarColor borderSelectTxt borderSelectBkg . wrap " " " "
  , ppTitle   = xmobarColor "#d79fcf" ""
  , ppVisible = wrap "[" "]"
  , ppUrgent  = xmobarColor "red" "yellow"
  }

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig { XMonad.modMask = m } = (m, xK_b)

conf = def
  { terminal            = "urxvt"
  , focusFollowsMouse   = False
  , layoutHook          = layouts
  , focusedBorderColor  = "#000000"
  , normalBorderColor   = "#ffffff"
  , borderWidth         = 1
  , workspaces          = ["term", "code", "http", "media", "misc"]
  , clickJustFocuses    = False
  } `additionalKeys`
    [ ((mod1Mask,               xK_Down),   nextWS)
    , ((mod1Mask,               xK_Up),     prevWS)
    , ((mod1Mask .|. shiftMask, xK_Down),   shiftToNext)
    , ((mod1Mask .|. shiftMask, xK_Up),     shiftToPrev)
    , ((mod1Mask,               xK_Right),  nextScreen)
    , ((mod1Mask,               xK_Left),   prevScreen)
    , ((mod1Mask .|. shiftMask, xK_Right),  shiftNextScreen)
    , ((mod1Mask .|. shiftMask, xK_Left),   shiftPrevScreen)
    , ((mod1Mask,               xK_p),      spawn "rofi -show run")
    ]
