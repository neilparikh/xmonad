import XMonad
import XMonad.Util.CustomKeys
import XMonad.Layout.Tabbed
import XMonad.Layout.NoFrillsDecoration
import XMonad.Hooks.DynamicLog

myLayout = noFrillsDeco shrinkText def (layoutHook def) ||| simpleTabbed

main = do
  let conf = def {
      borderWidth = 2
    , layoutHook  = myLayout
    , keys        = customKeys delkeys inskeys
    -- , modMask     = mod4Mask
  }
  config <- xmobar conf
  xmonad config
  where
  delkeys XConfig {modMask = modm} = []
  inskeys conf@(XConfig {modMask = modm}) =
      [ ((modm .|. controlMask, xK_Delete), spawn "light-locker-command --lock")
      , ((modm .|. controlMask, xK_Print),  spawn "scrot -u '%F_%T_%s.png' -e 'mv $f ~/Pictures/screenshots/'")
      ]
