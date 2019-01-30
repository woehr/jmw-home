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
          [ "-t", "CPU: <total0> <total1> <total2> <total3> <total4> <total5> <total6> <total7> <total8> <total9> <total10> <total11> <total12> <total13> <total14> <total15>"
          , "-w", "3"
          ] 10
       , Run Memory
          [ "-t", "Mem: <usedratio>%"
          ] 10
       , Run DiskU [("/", "/: <used>/<size>")]
          [ "-m", "1"
          ] 10
       , Run DiskIO [("nvme0n1", "nvme0n1: <read>, <write>")]
       --, Run DiskIO [("sda", "sda: <read>, <write>")]
          [ "-m", "1"
          , "-w", "4"
          ] 10
       , Run Network "wlp29s0f3u2"
       --, Run Network "enp0s3
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
                 \   [%wlp29s0f3u2%]\
                 \   [%CYYC%]\
                 \   [%date%]\
                 \   "
                 --   \   [%enp0s3%]\
    }
''
