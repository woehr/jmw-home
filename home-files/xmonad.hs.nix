{ pkgs
, follow-mouse
, xmobar-config, xmobar-title-color, xmobar-workspace-color
}:
''
  import System.IO
  import XMonad
  import XMonad.Hooks.DynamicLog
  import XMonad.Hooks.ManageDocks
  import XMonad.Util.Run (spawnPipe)

  -- https://github.com/vicfryzel/xmonad-config/blob/master/xmonad.hs

  baseConfig = defaultConfig
    { terminal = "urxvt"
    , borderWidth = 2
    , focusFollowsMouse = ${if follow-mouse then "True" else "False"}
    }

  main = do
    cfg <- statusBar
            "${pkgs.haskellPackages.xmobar}/bin/xmobar ${xmobar-config}"
            xmobarPP
              { ppTitle = xmobarColor "${xmobar-title-color}" "" . shorten 100
              , ppCurrent = xmobarColor "${xmobar-workspace-color}" ""
              , ppSep = "   "
              }
            (\(XConfig{modMask = modm}) -> (modm, xK_b))
            baseConfig
    xmonad cfg
''
