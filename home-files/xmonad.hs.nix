{ pkgs
, follow-mouse, xmonad-border-color
, xmobar-config, xmobar-title-color, xmobar-workspace-color
}:
''
  import Control.Exception  (SomeException, catch)
  import Data.List          (intercalate)
  import System.IO
  import System.Posix.IO

  import qualified Data.Map as M
  import qualified Data.Text as T
  import qualified Data.Text.IO as T

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
    , ((modm .|. controlMask, xK_l), spawn "${pkgs.xlockmore}/bin/xlock -mode blank")
    ]
  baseConfig lh = defaultConfig
    { modMask = mod1Mask
    , terminal = "urxvt"
    , borderWidth = 2
    , focusedBorderColor = "${xmonad-border-color}"
    , focusFollowsMouse = ${if follow-mouse then "True" else "False"}
    , layoutHook = let rtall = ResizableTall 1 (1/20) (1/2) []
                       tall  = Tall 1 (1/20) (1/2)
                   in avoidStruts $ rtall ||| Mirror rtall ||| tall ||| Mirror tall ||| Full
    , logHook = lh
    , keys = \c -> keys defaultConfig c `M.union` keyBinds c
    , handleEventHook = docksEventHook <+> fullscreenEventHook
    , workspaces = fmap show [1..9]
    , manageHook = composeAll
      [ className =? "Chromium-browser" --> doShift "1"
      , className =? "Slack"            --> doShift "2"
      ] <+> manageDocks
    , startupHook = do
        spawn "${pkgs.chromium}/bin/chromium"
        spawn "${pkgs.slack}/bin/slack"
    }

  takeUntil :: Eq a => a -> [a] -> [a]
  takeUntil _ [] = []
  takeUntil x (a:as) = if a == x then [] else a:takeUntil x as

  mkLogHook xmbInput = dynamicLogWithPP xmobarPP
    { ppOutput = \s -> T.hPutStrLn xmbInput (T.pack s)
    , ppHidden = takeUntil ':'
    , ppTitle = xmobarColor "${xmobar-title-color}" "" . shorten 100
    , ppExtras = []
    , ppCurrent = xmobarColor "${xmobar-workspace-color}" ""
    , ppSep = "   "
    }

  catch' :: IO a -> (SomeException -> IO a) -> IO a
  catch' = catch

  tryOpenFile fname =
    let openFdSetOpts f = do
          fd <- openFd f ReadWrite Nothing defaultFileFlags
          setFdOption fd CloseOnExec True
          return fd
    in openFdSetOpts fname `catch'` \e -> openFdSetOpts "/dev/null"

  main = do
    xmbInput <- tryOpenFile "/home/jordan/.local/share/xmobar/xmobar.pipe" >>= fdToHandle
    hSetBuffering xmbInput LineBuffering

    xmonad $ ewmh $ baseConfig (mkLogHook xmbInput)

    hClose xmbInput
''
