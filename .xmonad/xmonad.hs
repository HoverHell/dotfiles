
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

import XMonad.Hooks.SetWMName  -- javafix.

-- rebinding
import qualified XMonad.StackSet as W
import System.Exit ( exitWith, ExitCode(ExitSuccess) )
 

myMod = mod4Mask -- windows key
myTerminal = "xterm"

{-
myTheme = defaultTheme {
    activeColor         = blue
  , inactiveColor       = grey
  , activeBorderColor   = blue
  , inactiveBorderColor = grey
  , activeTextColor     = "white"
  , inactiveTextColor   = "black"
  , decoHeight          = 16
  }
    where
      blue = "#4a708b" -- same color used by gnome pager
      grey = "#cccccc"
-}
-- normalBorderColor  = "gray"


myManageHook = composeAll
    [ className =? "Vncviewer" --> doFloat
    -- className =? "Gimp"      --> doFloat  -- actually, gimp tiles quite nicely.
    ]
  -- use with:
  -- manageHook = manageDocks <+> myManageHook
  --               <+> manageHook defaultConfig

myWorkspaces    = ["1","2","3","4","5","6","7","8"]

myKeymap = [
      ("M4-C-M1-l", spawn "xscreensaver-command -lock")  -- lock for safety
    , ("C-M1-l", spawn "sleep 0.5 && xset s activate")  -- turn off display (maybe)
    , ("M4-`", spawn "/home/hell/bin/dmenu_run")  -- for the start!
    , ("C-M1-z", spawn "/home/hell/bin/scr")  -- screenshot.
    , ("M1-<Esc>", kill)  -- habitual 'close'
    ---- Controlling stuff with mod-shift
    -- Master area size
    , ("M4-C-q", sendMessage Expand)
    , ("M4-C-a", sendMessage Shrink)
    -- Number of masters
    , ("M4-C-e", sendMessage (IncMasterN 1))
    , ("M4-C-d", sendMessage (IncMasterN (-1)))
    -- Windows order and focusing.
    , ("M4-S-z", windows W.swapDown)
    , ("M4-S-x", windows W.swapUp)
    , ("M4-z", windows W.focusDown)
    , ("M4-x", windows W.focusUp)
    ---- 
    ---- Put somewhere else stuff that was replaced:
    , ("M4-C-S-;", io (exitWith ExitSuccess))
    , ("M4-S-;", spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    ---- Workspaces and clients:
    ---- [Shift+] [q..r, a..f, v]
    [("M4-" ++ otherModMasks ++ [key], action tag)
         | (tag, key)  <- zip myWorkspaces "qwerasdfv"
         , (otherModMasks, action) <- [ ("", windows . W.greedyView) -- or W.view?
                                      , ("S-", windows . W.shift)]
    ]
    {- ++
    ---- Physical / Xinerama screens.
    ---- [Shift+] [y..o]
    [("M4-" ++ otherModMasks ++ [key], action scr)
         | (key, scr)  <- zip "yuio" [0..]
         , (otherModMasks, action) <- [ ("", W.View)
                                      , ("S-", W.shift)]
    ]
    -}


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/hell/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 100
            }
        , startupHook = setWMName "LG3D"  -- java fix
        , modMask = mod4Mask       -- Rebind Mod to the Windows key
        , XMonad.focusedBorderColor = "#001080"  -- "blue"
        , XMonad.normalBorderColor  = "gray"
        } `additionalKeysP` myKeymap
