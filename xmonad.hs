
------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
    -- Base
import           XMonad
import           XMonad.Config.Desktop
import           Data.Monoid
import           Data.Maybe                     ( isJust )
import           System.IO                      ( hPutStrLn )
import           System.Exit                    ( exitSuccess )
import qualified XMonad.StackSet               as W

    -- Utilities
import           XMonad.Util.Loggers
import           XMonad.Util.EZConfig           ( additionalKeysP
                                                , additionalMouseBindings
                                                )
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.SpawnOnce
import           XMonad.Util.Run                ( safeSpawn
                                                , unsafeSpawn
                                                , runInTerm
                                                , spawnPipe
                                                )

    -- Hooks
import           XMonad.Hooks.DynamicBars
import           XMonad.Hooks.DynamicLog        ( dynamicLogWithPP
                                                , defaultPP
                                                , wrap
                                                , pad
                                                , xmobarPP
                                                , xmobarColor
                                                , shorten
                                                , PP(..)
                                                )
import           XMonad.Hooks.ManageDocks       ( avoidStruts
                                                , docksStartupHook
                                                , manageDocks
                                                , ToggleStruts(..)
                                                )
import           XMonad.Hooks.ManageHelpers     ( isFullscreen
                                                , isDialog
                                                , doFullFloat
                                                , doCenterFloat
                                                )
import           XMonad.Hooks.Place             ( placeHook
                                                , withGaps
                                                , smart
                                                )
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

    -- Actions
import           XMonad.Actions.Minimize        ( minimizeWindow )
import           XMonad.Actions.Promote
import           XMonad.Actions.RotSlaves       ( rotSlavesDown
                                                , rotAllDown
                                                )
import           XMonad.Actions.CopyWindow      ( kill1
                                                , copyToAll
                                                , killAllOtherCopies
                                                , runOrCopy
                                                )
import           XMonad.Actions.WindowGo        ( runOrRaise
                                                , raiseMaybe
                                                )
import           XMonad.Actions.WithAll         ( sinkAll
                                                , killAll
                                                )
import           XMonad.Actions.CycleWS         ( moveTo
                                                , nextScreen
                                                , shiftTo
                                                , WSType(..)
                                                , shiftNextScreen
                                                , shiftPrevScreen
                                                )
import           XMonad.Actions.GridSelect
import           XMonad.Actions.DynamicWorkspaces
                                                ( addWorkspacePrompt
                                                , removeEmptyWorkspace
                                                )
import           XMonad.Actions.MouseResize
import qualified XMonad.Actions.ConstrainedResize
                                               as Sqr

    -- Layouts modifiers
import           XMonad.Layout.PerWorkspace     ( onWorkspace )
import           XMonad.Layout.Renamed          ( renamed
                                                , Rename(CutWordsLeft, Replace)
                                                )
import           XMonad.Layout.WorkspaceDir
import           XMonad.Layout.Spacing
import           XMonad.Layout.NoBorders
import           XMonad.Layout.LimitWindows     ( limitWindows
                                                , increaseLimit
                                                , decreaseLimit
                                                )
import           XMonad.Layout.WindowArranger   ( windowArrange
                                                , WindowArrangerMsg(..)
                                                )
import           XMonad.Layout.Reflect          ( reflectVert
                                                , reflectHoriz
                                                , REFLECTX(..)
                                                , REFLECTY(..)
                                                )
import           XMonad.Layout.MultiToggle      ( mkToggle
                                                , single
                                                , EOT(EOT)
                                                , Toggle(..)
                                                , (??)
                                                )
import           XMonad.Layout.MultiToggle.Instances
                                                ( StdTransformers
                                                  ( NBFULL
                                                  , MIRROR
                                                  , NOBORDERS
                                                  )
                                                )
import qualified XMonad.Layout.ToggleLayouts   as T
                                                ( toggleLayouts
                                                , ToggleLayout(Toggle)
                                                )

    -- Layouts
import           XMonad.Layout.GridVariants     ( Grid(Grid) )
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.OneBig
import           XMonad.Layout.Column
import           XMonad.Layout.ThreeColumns
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.ZoomRow          ( zoomRow
                                                , zoomIn
                                                , zoomOut
                                                , zoomReset
                                                , ZoomMessage(ZoomFullToggle)
                                                )
import           XMonad.Layout.IM               ( withIM
                                                , Property(Role)
                                                )

    -- Prompts
import           XMonad.Prompt                  ( defaultXPConfig
                                                , XPConfig(..)
                                                , XPPosition(Top)
                                                , Direction1D(..)
                                                )

------------------------------------------------------------------------
---CONFIG
------------------------------------------------------------------------
myFont = "xft:Iosevka SS14:bold:pixelsize=11"
myModMask = mod1Mask  -- Sets modkey to super/windows key
myTerminal = "kitty"      -- Sets default terminal
myTextEditor = "nvim"     -- Sets default text editor
myBorderWidth = 2         -- Sets border width for windows
myWorkspaces =
  ["ONE", "TWO", "THREE", "FOUR"]

myStartupHook :: X ()
myStartupHook =
  spawnOnce "picom --xrender-sync-fence"
    <+> spawnOnce "Esetroot /home/mishakos/Pictures/wall.png"
    <+> spawnOnce "xsetroot -cursor_name left_ptr"
    <+> setWMName "LG3D"
windowCount =
  gets
    $ Just
    . show
    . length
    . W.integrate'
    . W.stack
    . W.workspace
    . W.current
    . windowset

main = do
    -- Launching xmobar.
  xmproc <- spawnPipe "xmobar $HOME/.xmonad/xmobar.hs"
      -- the xmonad, ya know...what the WM is named after!
  xmonad
    $                 desktopConfig
                        { manageHook         = (isFullscreen --> doFullFloat)
                                               <+> myManageHook
                                               <+> manageHook desktopConfig
                                               <+> manageDocks
                        , logHook            = dynamicLogWithPP xmobarPP
                                                 { ppOutput = \x -> hPutStrLn xmproc x
                                                 , ppCurrent = xmobarColor "#fb4934" "" . wrap "[" "]" -- Current workspace in xmobar
                                                 , ppVisible = xmobarColor "#d57614" ""                -- Visible but not current workspace
                                                 , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                                                 , ppHiddenNoWindows = xmobarColor "#ebdbb2" ""        -- Hidden workspaces (no windows)
                                                 , ppTitle = xmobarColor "#ebdbb2" "" . shorten 80     -- Title of active window in xmobar
                                                 , ppSep = "<fc=#d65d0e> : </fc>"                     -- Separators in xmobar
                                                 , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                                                 , ppExtras = [windowCount]                           -- # of windows current workspace
                                                 , ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                                                 }
                        , startupHook        = myStartupHook
                        , modMask            = myModMask
                        , terminal           = myTerminal
                        , layoutHook         = myLayoutHook
                        , borderWidth        = myBorderWidth
                        , workspaces         = myWorkspaces
                        , normalBorderColor  = "#292d3e"
                        , focusedBorderColor = "#dc322f"
                        }
    `additionalKeysP` myKeys


------------------------------------------------------------------------
---GRID SELECT
------------------------------------------------------------------------

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName (0x31, 0x2e, 0x39) -- lowest inactive bg
                                      (0x31, 0x2e, 0x39) -- highest inactive bg
                                      (0x61, 0x57, 0x72) -- active bg
                                      (0xc0, 0xa7, 0x9a) -- inactive fg
                                      (0xff, 0xff, 0xff) -- active fg

-- gridSelect menu layout
mygridConfig colorizer = (buildDefaultGSConfig myColorizer) { gs_cellheight = 30
                                                            , gs_cellwidth = 200
                                                            , gs_cellpadding = 8
                                                            , gs_originFractX = 0.5
                                                            , gs_originFractY = 0.5
                                                            , gs_font = myFont
                                                            }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where conf = def

------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
myKeys =
    --- Xmonad
  [ ( "M-C-r"
    , spawn "xmonad --recompile"
    )      -- Recompiles xmonad
  , ( "M-0-r"
    , spawn "xmonad --restart"
    )        -- Restarts xmonad
  , ( "M-C-q"
    , io exitSuccess
    )                  -- Quits xmonad

    --- Windows
  , ( "M-q"
    , kill1
    )                           -- Kill the currently focused client

    --- Floating windows
  , ( "M-<Delete>"
    , withFocused $ windows . W.sink
    )  -- Push floating window back to tile.
  , ( "M-S-<Delete>"
    , sinkAll
    )                  -- Push ALL floating windows back to tile.

    --- Windows navigation
  , ( "M-m"
    , windows W.focusMaster
    )             -- Move focus to the master window
  , ("M-y", nextScreen)
  , ( "M-j"
    , windows W.focusDown
    )               -- Move focus to the next window
  , ( "M-k"
    , windows W.focusUp
    )                 -- Move focus to the prev window
  , ( "M-C-m"
    , windows W.swapMaster
    )            -- Swap the focused window and the master window
  , ( "M-C-j"
    , windows W.swapDown
    )              -- Swap the focused window with the next window
  , ( "M-C-k"
    , windows W.swapUp
    )                -- Swap the focused window with the prev window
  , ( "M-<Backspace>"
    , promote
    )                 -- Moves focused window to master, all others maintain order
  , ( "M1-S-<Tab>"
    , rotSlavesDown
    )              -- Rotate all windows except master and keep focus in place
  , ( "M1-C-<Tab>"
    , rotAllDown
    )                 -- Rotate all the windows in the current stack
  , ("M-S-s"        , windows copyToAll)
  , ("M-C-s"        , killAllOtherCopies)
  , ("M-C-M1-<Up>"  , sendMessage Arrange)
  , ("M-C-M1-<Down>", sendMessage DeArrange)
  , ( "M-<Up>"
    , sendMessage (MoveUp 10)
    )             --  Move focused window to up
  , ( "M-<Down>"
    , sendMessage (MoveDown 10)
    )         --  Move focused window to down
  , ( "M-<Right>"
    , sendMessage (MoveRight 10)
    )       --  Move focused window to right
  , ( "M-<Left>"
    , sendMessage (MoveLeft 10)
    )         --  Move focused window to left
  , ( "M-S-<Up>"
    , sendMessage (IncreaseUp 10)
    )       --  Increase size of focused window up
  , ( "M-S-<Down>"
    , sendMessage (IncreaseDown 10)
    )   --  Increase size of focused window down
  , ( "M-S-<Right>"
    , sendMessage (IncreaseRight 10)
    ) --  Increase size of focused window right
  , ( "M-S-<Left>"
    , sendMessage (IncreaseLeft 10)
    )   --  Increase size of focused window left
  , ( "M-C-<Up>"
    , sendMessage (DecreaseUp 10)
    )       --  Decrease size of focused window up
  , ( "M-C-<Down>"
    , sendMessage (DecreaseDown 10)
    )   --  Decrease size of focused window down
  , ( "M-C-<Right>"
    , sendMessage (DecreaseRight 10)
    ) --  Decrease size of focused window right
  , ( "M-C-<Left>"
    , sendMessage (DecreaseLeft 10)
    )   --  Decrease size of focused window left

    --- Layouts
  , ( "M-<Space>"
    , sendMessage NextLayout
    )                              -- Switch to next layout
  , ( "M-S-<Space>"
    , sendMessage ToggleStruts
    )                          -- Toggles struts
  , ( "M-S-n"
    , sendMessage $ Toggle NOBORDERS
    )                          -- Toggles noborder
  , ( "M-f"
    , sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts
    ) -- Toggles noborder/full
  , ("M-S-f", sendMessage (T.Toggle "float"))
  , ("M-S-x", sendMessage $ Toggle REFLECTX)
  , ("M-S-y", sendMessage $ Toggle REFLECTY)
  , ("M-S-m", sendMessage $ Toggle MIRROR)
  , ( "M-<KP_Multiply>"
    , sendMessage (IncMasterN 1)
    )   -- Increase number of clients in the master pane
  , ( "M-<KP_Divide>"
    , sendMessage (IncMasterN (-1))
    )  -- Decrease number of clients in the master pane
  , ( "M-S-<KP_Multiply>"
    , increaseLimit
    )              -- Increase number of windows that can be shown
  , ( "M-S-<KP_Divide>"
    , decreaseLimit
    )                -- Decrease number of windows that can be shown
  , ("M-C-h", sendMessage Shrink)
  , ("M-C-l", sendMessage Expand)
  , ("M-C-j", sendMessage MirrorShrink)
  , ("M-C-k", sendMessage MirrorExpand)
  , ("M-S-;", sendMessage zoomReset)
  , ( "M-;"
    , sendMessage ZoomFullToggle
    )

    --- Workspaces
  , ( "M-<KP_Add>"
    , moveTo Next nonNSP
    )                                -- Go to next workspace
  , ( "M-<KP_Subtract>"
    , moveTo Prev nonNSP
    )                           -- Go to previous workspace
  , ( "M-S-<KP_Add>"
    , shiftTo Next nonNSP >> moveTo Next nonNSP
    )       -- Shifts focused window to next workspace
  , ( "M-S-<KP_Subtract>"
    , shiftTo Prev nonNSP >> moveTo Prev nonNSP
    )  -- Shifts focused window to previous workspace

    --- Open Terminal
  , ( "M-<Return>"
    , spawn myTerminal
    )

    --- My Applications (Super+Alt+Key)
  , ("<XF86AudioRaiseVolume>", spawn "amixer -c 2 set Speaker 3db+")
  , ("<XF86AudioLowerVolume>", spawn "amixer -c 2 set Speaker 3db-")
  , ("M-d"   , spawn "rofi -show run")
  , ("M-C-b" , spawn "kitty -e 'bmenu'")
  ] where
  nonNSP = WSIs (return (\ws -> W.tag ws /= "nsp"))
  nonEmptyNonNSP =
    WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))


myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook =
  composeAll
      [ className =? "XCalc" --> doFloat
      , (className =? "Firefox-esr" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
      ]

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------

myLayoutHook =
  avoidStruts
    $ mouseResize
    $ windowArrange
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
    $ myDefaultLayout
 where
  myDefaultLayout =
    tall
      ||| vertical


tall =
  renamed [Replace "tall"]
    $ limitWindows 12
    $ spacingRaw False (Border 0 10 10 10) True (Border 10 10 10 10) True
    $ ResizableTall 1 (3 / 100) (1 / 2) []
vertical =
  renamed [Replace "vertical"]
    $ spacingRaw False (Border 0 10 10 10) True (Border 10 10 10 10) True
    $ Column 2.0

