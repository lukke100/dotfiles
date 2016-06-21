import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Layout.GridVariants
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

brSelBg, brSelTx, brTtlTx, bdFocus, bdNorm :: String
brSelBg = "#7c60bf"
brSelTx = "#292929"
brTtlTx = "#7c60bf"
bdFocus = "#7c60bf"
bdNorm  = "#939393"

barPath :: String
barPath = "xmobar ~/.xmonad/xmobar.rc"

layouts = let
  tLayout  = Tall 1 (3/100) (1/2)
  layouts' = (spacing 24 $ Grid $ 16/10)
         ||| (spacing 24 tLayout)
         ||| (spacing 24 $ Mirror tLayout)
         ||| noBorders Full
  in layouts'

main :: IO ()
main = statusBar barPath barFmt toggleStrutsKey conf >>= xmonad

barFmt :: PP
barFmt = xmobarPP
  { ppCurrent = xmobarColor brSelTx brSelBg . wrap " λ " " "
  , ppTitle   = xmobarColor brTtlTx ""
  , ppVisible = wrap "[" "]"
  , ppUrgent  = xmobarColor "red" "yellow"
  }

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig { XMonad.modMask = m } = (m, xK_b)

conf = defaultConfig
  { terminal            = "urxvt"
  , focusFollowsMouse   = False
  , layoutHook          = smartBorders layouts
  , focusedBorderColor  = bdFocus
  , normalBorderColor   = bdNorm
  , borderWidth         = 2
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
