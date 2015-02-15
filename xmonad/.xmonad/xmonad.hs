import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Layout.GridVariants
import XMonad.Actions.CycleWS
import Data.List

brSelBg = "#dcdccc"
brSelTx = "#3f3f3f"
brTtlTx = "#ffffff"
bdFocus = "#3f3f3f"
bdNorm  = "#dcdccc"
dmenuArgs = intercalate " "
        [ "-f"
        , "-i"
        , "-q"
        , "-t"
        , "-w", "1904"
        , "-h", "12" -- Does not apply. Font limits height to 14
        , "-x", "12"
        , "-y", "11" -- Compensates for height being 14
        , "-p", q " -> "
        , "-nb", q "#3f3f3f" -- Normal background color
        , "-nf", q "#dcdccc" -- Normal foreground (text) color
        , "-sb", q "#dcdccc" -- Selected background color
        , "-sf", q "#3f3f3f" -- Selected foreground (text) color
        , "-dc", q "#3f3f3f" -- Dim color
        , "-fn", "Terminus-9"-- Text font
        ] where q s = '"':s++"\""

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
        } `additionalKeys`
                [ ((mod1Mask,                   xK_p),          spawn $ "dmenu_run " ++ dmenuArgs )
                , ((mod4Mask,                   xK_l),          spawn "xscreensaver-command -lock")
                , ((mod1Mask,                   xK_Down),       nextWS)
                , ((mod1Mask,                   xK_Up),         prevWS)
                , ((mod1Mask .|. shiftMask,     xK_Down),       shiftToNext)
                , ((mod1Mask .|. shiftMask,     xK_Up),         shiftToPrev)
                , ((mod1Mask,                   xK_Right),      nextScreen)
                , ((mod1Mask,                   xK_Left),       prevScreen)
                , ((mod1Mask .|. shiftMask,     xK_Right),      shiftNextScreen)
                , ((mod1Mask .|. shiftMask,     xK_Left),       shiftPrevScreen)
                ]

