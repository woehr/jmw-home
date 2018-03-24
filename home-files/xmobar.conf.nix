{ font }:
''
  Config
    { font = "xft:${font}:size=9"
    , additionalFonts = []
    , borderColor = "black"
    , border = TopB
    , bgColor = "black"
    , fgColor = "grey"
    , alpha = 255
    , position = Top
    , textOffset = -1
    , iconOffset = -1
    , lowerOnStart = True
    , pickBroadest = False
    , persistent = False
    , hideOnStart = False
    , iconRoot = "."
    , allDesktops = True
    , overrideRedirect = True
    , commands =
       [ Run MultiCpu
          [ "-t", "CPU: <total0> <total1>"
          , "-w", "3"
          ] 10
       , Run Memory
          [ "-t", "Mem: <usedratio>%"
          ] 10
       , Run DiskU [("/", "/: <used>/<size>")]
          [ "-m", "1"
          ] 10
       , Run DiskIO [("sda", "sda: <read>, <write>")]
          [ "-m", "1"
          , "-w", "4"
          ] 10
       , Run Network "enp0s3"
          [ "-t", "Net: <rx>, <tx>"
          , "-S", "True"
          , "-w", "6"
          ] 10
       , Run Weather "CYYC"
          [ "-t", "<station>: <tempC>C <skyCondition>"
          ] 3000
       , Run Date "%a %b %_d %l:%M" "date" 10
       , Run StdinReader
       ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%StdinReader% }{\
                 \   [%multicpu%]\
                 \   [%memory%]\
                 \   [%disku%]\
                 \   [%diskio%]\
                 \   [%enp0s3%]\
                 \   [%CYYC%]\
                 \   [%date%]\
                 \   "
    }
''
