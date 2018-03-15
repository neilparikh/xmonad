import XMonad
import XMonad.Util.CustomKeys
import XMonad.Layout.Tabbed
import XMonad.Layout.NoFrillsDecoration
import XMonad.Hooks.DynamicLog

myLayout = deco tiled ||| deco (Mirror tiled) ||| simpleTabbedAlways
  where
    -- add a title bar to the window
    deco    = noFrillsDeco shrinkText def

    -- from https://github.com/xmonad/xmonad/blob/master/src/XMonad/Config.hs#L136
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

main = do
  let conf = def {
      borderWidth = 2
    , layoutHook  = myLayout
    , keys        = customKeys delkeys inskeys
    -- , modMask     = mod4Mask
  }
  xmobar conf >>= xmonad
  where
  delkeys XConfig {modMask = modm} = []
  inskeys conf@(XConfig {modMask = modm}) =
      [ ((modm .|. controlMask, xK_Delete), spawn "light-locker-command --lock")
      , ((mod4Mask, xK_l),                  spawn "light-locker-command --lock")
      , ((modm .|. controlMask, xK_Print),  spawn "scrot -u '%F_%T_%s.png' -e 'mv $f ~/Pictures/screenshots/'")
      ]
