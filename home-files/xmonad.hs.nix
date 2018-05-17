{ pkgs
, follow-mouse
, xmobar-config, xmobar-title-color, xmobar-workspace-color
}:
''
  import qualified Data.Map as M

  import XMonad
  import XMonad.Hooks.DynamicLog
  import XMonad.Hooks.ManageDocks
  import XMonad.Hooks.EwmhDesktops
  import XMonad.Layout.ResizableTile

  -- https://github.com/vicfryzel/xmonad-config/blob/master/xmonad.hs

  -- Custom key binds
  -- These will override defaults if the same bind is already defined
  keyBinds conf@(XConfig{modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_h), sendMessage MirrorExpand)
    , ((modm .|. shiftMask, xK_l), sendMessage MirrorShrink)
    ]
  baseConfig = defaultConfig
    { modMask = mod1Mask
    , terminal = "urxvt"
    , borderWidth = 2
    , focusFollowsMouse = ${if follow-mouse then "True" else "False"}
    , layoutHook = let rtall = ResizableTall 1 (1/20) (1/2) []
                       tall  = Tall 1 (1/20) (1/2)
                   in  rtall ||| Mirror rtall ||| tall ||| Mirror tall ||| Full
    , keys = \c -> keys defaultConfig c `M.union` keyBinds c
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    }

  main = do
    cfg <- statusBar
            "${pkgs.haskellPackages.xmobar}/bin/xmobar ${xmobar-config}"
            xmobarPP
              { ppTitle = xmobarColor "${xmobar-title-color}" "" . shorten 100
              , ppCurrent = xmobarColor "${xmobar-workspace-color}" ""
              , ppSep = "   "
              }
            (\(XConfig{modMask = modm}) -> (modm, xK_quoteleft))
            baseConfig
    xmonad $ ewmh cfg
''
