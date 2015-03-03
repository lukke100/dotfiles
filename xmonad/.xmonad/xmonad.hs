import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Layout.GridVariants
import XMonad.Actions.CycleWS

brSelBg, brSelTx, brTtlTx, bdFocus, bdNorm :: String
brSelBg = "#dcdccc"
brSelTx = "#3f3f3f"
brTtlTx = "#ffffff"
bdFocus = "#3f3f3f"
bdNorm  = "#dcdccc"

barPath :: String
barPath = "xmobar ~/.xmonad/xmobar.rc"

layouts =   (spacing 12 $ Grid (16/9))
        ||| (spacing 12 $ Tall 1 (3/100) (1/2))
        ||| (spacing 12 $ Mirror $ Tall 1 (3/100) (1/2))
        ||| Full

main :: IO ()
main = statusBar barPath barFmt toggleStrutsKey conf >>= xmonad

barFmt :: PP
barFmt = xmobarPP
        { ppCurrent   = xmobarColor brSelTx brSelBg . wrap " -:" ":- "
        , ppTitle     = xmobarColor brTtlTx "" . shorten 200
        , ppVisible   = wrap "(" ")"
        , ppUrgent    = xmobarColor "red" "yellow"
        }

toggleStrutsKey XConfig {XMonad.modMask = m} = (m, xK_b)

conf = ewmh $ defaultConfig
        { terminal              = "urxvt"
        , focusFollowsMouse     = False
        , layoutHook            = smartBorders layouts
        , focusedBorderColor    = bdFocus
        , normalBorderColor     = bdNorm
        , borderWidth           = 1
        , workspaces            = ["term", "code", "http", "media", "misc"]
        , handleEventHook       = handleEventHook defaultConfig <+> fullscreenEventHook
        , clickJustFocuses      = False
        }
        `additionalKeys`
                [ ((mod4Mask,                   xK_l),          spawn "xscreensaver-command -lock")
                , ((mod1Mask,                   xK_Down),       nextWS)
                , ((mod1Mask,                   xK_Up),         prevWS)
                , ((mod1Mask .|. shiftMask,     xK_Down),       shiftToNext)
                , ((mod1Mask .|. shiftMask,     xK_Up),         shiftToPrev)
                , ((mod1Mask,                   xK_Right),      nextScreen)
                , ((mod1Mask,                   xK_Left),       prevScreen)
                , ((mod1Mask .|. shiftMask,     xK_Right),      shiftNextScreen)
                , ((mod1Mask .|. shiftMask,     xK_Left),       shiftPrevScreen)
                ]
        `removeKeys`
                [ (mod1Mask,                    xK_p)
                ]

