{ font }:
''
  URxvt.font:                 xft:${font}:size=10
  XTerm*faceName:             xft:${font}:size=10
  XTerm*utf8:                 2
  URxvt.letterSpace:          0

  URxvt.background:           #121212
  URxvt.foreground:           #FFFFFF
  XTerm*background:           #121212
  XTerm*foreground:           #FFFFFF
  ! black
  URxvt.color0  :             #2E3436
  URxvt.color8  :             #555753
  XTerm*color0  :             #2E3436
  XTerm*color8  :             #555753
  ! red
  URxvt.color1  :             #CC0000
  URxvt.color9  :             #EF2929
  XTerm*color1  :             #CC0000
  XTerm*color9  :             #EF2929
  ! green
  URxvt.color2  :             #4E9A06
  URxvt.color10 :             #8AE234
  XTerm*color2  :             #4E9A06
  XTerm*color10 :             #8AE234
  ! yellow
  URxvt.color3  :             #C4A000
  URxvt.color11 :             #FCE94F
  XTerm*color3  :             #C4A000
  XTerm*color11 :             #FCE94F
  ! blue
  URxvt.color4  :             #3465A4
  URxvt.color12 :             #729FCF
  XTerm*color4  :             #3465A4
  XTerm*color12 :             #729FCF
  ! magenta
  URxvt.color5  :             #75507B
  URxvt.color13 :             #AD7FA8
  XTerm*color5  :             #75507B
  XTerm*color13 :             #AD7FA8
  ! cyan
  URxvt.color6  :             #06989A
  URxvt.color14 :             #34E2E2
  XTerm*color6  :             #06989A
  XTerm*color14 :             #34E2E2
  ! white
  URxvt.color7  :             #D3D7CF
  URxvt.color15 :             #EEEEEC
  XTerm*color7  :             #D3D7CF
  XTerm*color15 :             #EEEEEC

  URxvt*saveLines:            32767
  XTerm*saveLines:            32767
  URxvt.colorUL:              #AED210
  URxvt.url-select.underline: true
  Xft*dpi:                    96
  Xft*antialias:              true
  Xft*hinting:                full
  URxvt.scrollBar:            false
  URxvt*scrollTtyOutput:      false
  URxvt*scrollWithBuffer:     true
  URxvt*scrollTtyKeypress:    true
  URxvt*scrollstyle:          plain
  URxvt*secondaryScroll:      false
  Xft.autohint: 0
  Xft.lcdfilter:  lcddefault
  Xft.hintstyle:  hintfull
  Xft.hinting: 1
  Xft.antialias: 1

  ! http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal?useskin=monobook
  ! emulate XTerm for proper recognition of key combinations in Vim
  URxvt.keysym.S-Up             : \033[1;2A
  URxvt.keysym.S-Down           : \033[1;2B
  URxvt.keysym.S-Right          : \033[1;2C
  URxvt.keysym.S-Left           : \033[1;2D
  URxvt.keysym.S-Home           : \033[1;2H
  URxvt.keysym.S-End            : \033[1;2F
  URxvt.keysym.M-Up             : \033[1;3A
  URxvt.keysym.M-Down           : \033[1;3B
  URxvt.keysym.M-Right          : \033[1;3C
  URxvt.keysym.M-Left           : \033[1;3D
  URxvt.keysym.M-Page_Up        : \033[5;3~
  URxvt.keysym.M-Page_Down      : \033[6;3~
  URxvt.keysym.M-Home           : \033[1;3H
  URxvt.keysym.M-End            : \033[1;3F
  URxvt.keysym.M-S-Up           : \033[1;4A
  URxvt.keysym.M-S-Down         : \033[1;4B
  URxvt.keysym.M-S-Right        : \033[1;4C
  URxvt.keysym.M-S-Left         : \033[1;4D
  URxvt.keysym.M-S-Home         : \033[1;4H
  URxvt.keysym.M-S-End          : \033[1;4F
  URxvt.keysym.C-Up             : \033[1;5A
  URxvt.keysym.C-Down           : \033[1;5B
  URxvt.keysym.C-Right          : \033[1;5C
  URxvt.keysym.C-Left           : \033[1;5D
  URxvt.keysym.C-Page_Up        : \033[5;5~
  URxvt.keysym.C-Page_Down      : \033[6;5~
  URxvt.keysym.C-Home           : \033[1;5H
  URxvt.keysym.C-End            : \033[1;5F
  URxvt.keysym.C-S-Up           : \033[1;6A
  URxvt.keysym.C-S-Down         : \033[1;6B
  URxvt.keysym.C-S-Right        : \033[1;6C
  URxvt.keysym.C-S-Left         : \033[1;6D
  URxvt.keysym.C-S-Home         : \033[1;6H
  URxvt.keysym.C-S-End          : \033[1;6F
  URxvt.keysym.M-C-Up           : \033[1;7A
  URxvt.keysym.M-C-Down         : \033[1;7B
  URxvt.keysym.M-C-Right        : \033[1;7C
  URxvt.keysym.M-C-Left         : \033[1;7D
  URxvt.keysym.M-C-Page_Up      : \033[5;7~
  URxvt.keysym.M-C-Page_Down    : \033[6;7~
  URxvt.keysym.M-C-Home         : \033[1;7H
  URxvt.keysym.M-C-End          : \033[1;7F
  URxvt.keysym.M-C-S-Up         : \033[1;8A
  URxvt.keysym.M-C-S-Down       : \033[1;8B
  URxvt.keysym.M-C-S-Right      : \033[1;8C
  URxvt.keysym.M-C-S-Left       : \033[1;8D
  URxvt.keysym.M-C-S-Home       : \033[1;8H
  URxvt.keysym.M-C-S-End        : \033[1;8F
''
