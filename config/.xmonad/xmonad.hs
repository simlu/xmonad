{- xmonad.hs
 - Author: Øyvind 'Mr.Elendig' Heggstad <mrelendig AT har-ikkje DOT net>
 - Version: 0.0.9
 - Modified version
 -}

-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import System.IO (Handle, hPutStrLn)
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops

-- utils
import XMonad.Util.Run (spawnPipe)

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

-------------------------------------------------------------------------------
-- Main --
main = do
       xmproc <- spawnPipe "xmobar"
       xmonad $ ewmh $ def
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , mouseBindings = myMouseBindings
              , layoutHook = layoutHook'
              , manageHook = manageHook'
              , focusFollowsMouse = myFocusFollowsMouse
              , clickJustFocuses = myClickJustFocuses
              , startupHook = startupHook'
              , handleEventHook = handleEventHook def <+> docksEventHook <+> fullscreenEventHook
              }

-------------------------------------------------------------------------------
-- Hooks --

manageHook' :: ManageHook
manageHook' = manageHook def <+> manageDocks

layoutHook' = customLayout

startupHook' :: X ()
startupHook' = spawn ". ~/.xmonad/autostart"

-------------------------------------------------------------------------------
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether a mouse click select the focus or is just passed to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- borders
borderWidth' :: Dimension
borderWidth' = 1

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#000000"
focusedBorderColor' = "#FF0000"

-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

-- layouts
customLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled)  ||| smartBorders Full
  where
    tiled = ResizableTall 1 (2/100) (1/2) []

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "xterm"

-------------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w
                                         >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod1Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- print screen
    [ ((modMask .|. controlMask, xK_p   ), spawn "sleep 0.2; import ~/screenshot.png")

    -- launching and killing programs
    , ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask .|. shiftMask, xK_m     ), spawn "claws-mail")

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask .|. shiftMask, xK_b     ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
    , ((modMask,               xK_f     ), withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1))
    , ((modMask .|. controlMask, xK_f   ), withFocused $ windows . (flip W.float $ W.RationalRect 0.1 0.1 0.8 0.8))

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- move focus between screens
    , ((modMask .|. controlMask, xK_Right), prevScreen)
    , ((modMask .|. controlMask, xK_Left),  nextScreen)
    , ((modMask .|. controlMask, xK_o),  shiftNextScreen)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    --, ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- XF86AudioMute
    , ((0 , 0x1008ff12), spawn "amixer -q set PCM toggle")
    -- XF86AudioLowerVolume
    , ((0 , 0x1008ff11), spawn "amixer -q set PCM 1- unmute")
    -- XF86AudioRaiseVolume
    , ((0 , 0x1008ff13), spawn "amixer -q set PCM 1+ unmute")
    --XF86Launch1 :1008FF41
    , ((0 , 0x1008FF41), windows $ W.greedyView "1-Main")
    --XF86Launch2 :1008FF42
    , ((0 , 0x1008FF42), windows $ W.greedyView "2-Temp")
    --XF86Launch3 :1008FF43
    , ((0 , 0x1008FF43), windows $ W.greedyView "3-Work")
    --XF86Launch4 :1008FF44
    , ((0 , 0x1008FF44), windows $ W.greedyView "4-Misc")
    --XF86Launch5 :1008FF45
    , ((0 , 0x1008FF45), windows $ W.greedyView "5-Msg")
    --XF86Launch6 :1008FF46
    , ((0 , 0x1008FF46), windows $ W.greedyView "6-Media")


    -- quit, or restart
    -- , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9, 0] %! Switch to workspace N
    -- mod-shift-[1..9, 0] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
