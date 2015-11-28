--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Maximize
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.TrackFloating
import XMonad.Layout.Reflect
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "xfce4-terminal"

-- Width of the window border in pixels.
--
myBorderWidth = 4

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt"). You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2 Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask = mod2Mask

-- Whether a mouse click select the focus or is just passed to the window
myClickJustFocuses = False

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["dev","web","present","gimp","dev-extra","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myEmacsTodo = "emacsclient -F '((title . \"TODO\"))' -c -e '(org-agenda nil \"t\")'"

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modMask, xK_d ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- launch xfce4-launcher
    , ((modMask, xK_p ), spawn "dmenu_run -b")

    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p ), spawn "xfce4-appfinder")

    -- take a screenshot
    , ((modMask, xK_Print ), spawn "xfce4-screenshooter -s ~/Pictures/screenshots")

    -- close focused window
    , ((modMask .|. shiftMask, xK_c ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask, xK_space ), sendMessage NextLayout)

    -- Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask, xK_n ), refresh)

    -- Move focus to the next window
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusDown)

      -- Move focus to the previous window
    , ((modMask .|. shiftMask, xK_Tab ), windows W.focusUp)
    , ((modMask, xK_k ), windows W.focusUp)

    -- Move focus to the master window
    , ((modMask .|. shiftMask, xK_m ), windows W.focusMaster )

    -- Maximize the focused window temporarily
    , ((modMask, xK_m ), withFocused $ sendMessage . maximizeRestore)

    -- Swap the focused window and the master window
    , ((modMask,	xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )

    -- Shrink the master area
    , ((modMask, xK_Left ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask, xK_Right ), sendMessage Expand)

    -- Shrink for ResizableTall
    , ((modMask, xK_Down), sendMessage MirrorShrink)

    -- Expand for ResizableTall
    , ((modMask, xK_Up), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modMask, xK_t ), withFocused $ windows . W.sink)

    -- Launch a emacs client with *TODO* buffer
    , ((modMask .|. shiftMask, xK_t), spawn myEmacsTodo)

    -- Increment the number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modMask , xK_b ),

    -- Lock screen
    , ((modMask .|. shiftMask, xK_l), spawn "xflock4")

    -- Quit xmonad
    --, ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask .|. shiftMask, xK_q ), spawn "xfce4-session-logout")

    -- Restart xmonad
    , ((modMask , xK_q ), restart "xmonad" True)

    -- to hide/unhide the panel
    , ((modMask , xK_b), sendMessage ToggleStruts)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- Layouts are defined by workspaces.

-- Default
myDefaultLayout = maximize (tiled) ||| Mirror tiled ||| Full
  where
     tiled = ResizableTall 1 (3/100) (1/2) []

-- devLayout = maximize $ Tall 1 (1/100) (2/3)
devLayout = maximize (ThreeColMid 1 (3/100) (1/2)) ||| myDefaultLayout

webLayout = myDefaultLayout


gimpLayout = withIM (1/12) (Role "gimp-toolbox") $ reflectHoriz
             $ withIM (1/12) (Role "gimp-dock") (trackFloating centralLayouts)
               where
                 centralLayouts = (simpleTabbed ||| spiral (6/7) ||| Grid)



presentLayout = maximize (Accordion ||| Grid)

-- All layouts together
myLayout = onWorkspace "dev" devLayout $
           onWorkspace "web" webLayout $
           onWorkspace "present" presentLayout $
           onWorkspace "gimp" gimpLayout $
           myDefaultLayout

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
-- className =? "Firefox" --> doShift "web"
myManageHook = composeAll
    [ className =? "Xfce4-notes" --> doFloat
    , className =? "Tk" --> doFloat
    , className =? "xli" --> doFloat
    , className =? "MPlayer" --> doFloat
    , className =? "Gimp" --> doShift "gimp"
    , className =? "Xfce4-appfinder" --> doFloat
    , className =? "Xfrun4" --> doFloat
    , title =? "Ediff" --> doFloat
    , resource =? "desktop_window" --> doIgnore
    , resource =? "kdesktop" --> doIgnore
    ]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q. Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--myStartupHook = return ()
myStartupHook = ewmhDesktopsStartup

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        modMask = myModMask,
        --numlockMask = myNumlockMask,
        workspaces = myWorkspaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        clickJustFocuses = myClickJustFocuses,

      -- key bindings
        keys = myKeys,
        mouseBindings = myMouseBindings,

      -- hooks, layouts
        layoutHook = avoidStruts $ myLayout,
        manageHook = manageDocks <+> myManageHook,
        logHook = ewmhDesktopsLogHook,
        startupHook = myStartupHook,
        handleEventHook = ewmhDesktopsEventHook


    }
