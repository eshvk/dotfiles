import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

import qualified Data.Map as M
import qualified XMonad.StackSet as W

main = xmonad $ gnomeConfig
    { keys       = newKeys
    , layoutHook = newLayout
    , manageHook = manageDocks
                <+> newManageHook
                <+> manageHook defaultConfig
    , modMask    = mod4Mask
    }

newLayout = smartBorders ( avoidStruts (
    (   ResizableTall 1 (3/100) (1/2) []
    ||| ThreeCol 1 (3/100) (1/3)
    ||| Grid
    ||| Full
    )))

newManageHook = composeAll
    [ className =? "Cssh"       --> doFloat
    , className =? "Spotify"    --> doFloat
    , className =? "Vlc"        --> doFloat
    , className =? "VirtualBox" --> doFloat
    ]

defKeys   = keys defaultConfig
delKeys x = foldr M.delete           (defKeys x) (toRemoveKeys x)
newKeys x = foldr (uncurry M.insert) (delKeys x) (toAddKeys    x)

toRemoveKeys XConfig{modMask = modm} =
    [ (modm,               xK_n)
    , (modm,               xK_p)
    , (modm .|. shiftMask, xK_p)
    ]

toAddKeys XConfig{modMask = modm} =
    [ ((modm,               xK_p),        spawn "gmrun")
    , ((modm,               xK_a),        sendMessage MirrorExpand)
    , ((modm,               xK_z),        sendMessage MirrorShrink)
    , ((modm,               xK_Right),    nextWS)
    , ((modm,               xK_Left),     prevWS)
    , ((modm .|. shiftMask, xK_Right),    shiftToNext)
    , ((modm .|. shiftMask, xK_Left),     shiftToPrev)
    , ((modm .|. shiftMask, xK_l),        spawn "gnome-screensaver-command -l")
    , ((modm,               xK_KP_Enter), windows W.swapMaster)
    ]
