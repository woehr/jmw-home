{pkgs, ...}:
let
  inherit (pkgs) writeText;

  # Default font for various things
  xft-font = "Dejavu Sans Mono";

  # xmonad configuration values
  xmonad-follow-mouse = true;
  xmonad-border-color = "#a40000";

  # xmobar configuration values
  xmobar-title-color = "#FFB6B0";
  xmobar-workspace-color = "#CEFFAC";

  # Config files as nix functions
  bazel-config = writeText "bazelrc" (import ./home-files/bazelrc.nix {
  });
  xrdb-config = writeText "xrdb.conf" (import ./home-files/xrdb.conf.nix {
    font = xft-font;
  });
  xmobar-config = writeText "xmobar.conf" (import ./home-files/xmobar.conf.nix {
    font = xft-font;
  });
  xmonad-config = writeText "xmonad.hs" (import ./home-files/xmonad.hs.nix {
    inherit pkgs xmonad-border-color; follow-mouse = xmonad-follow-mouse;
    inherit xmobar-config xmobar-title-color xmobar-workspace-color;
  });



  oldpkgsSrc = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "0252e6ca31c98182e841df494e6c9c4fb022c676";
    sha256 = "1sr5a11sb26rgs1hmlwv5bxynw2pl5w4h5ic0qv3p2ppcpmxwykz";
  };

  newpkgsSrc = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "1d0a71879dac0226272212df7a2463d8eeb8f75b";
    sha256 = "0nh6wfw50lx6wkzyiscfqg6fl6rb17wmncj8jsdvbgmsd6rm95rg";
  };

  oldpkgs = import oldpkgsSrc {};
  newpkgs = import newpkgsSrc {};

  my-emacs = import ./home-files/my-emacs.nix { inherit pkgs; };
  my-nvim = import ./home-files/my-neovim.nix { inherit pkgs; };

in {

  nixpkgs = {
    config = import ./home-files/nixpkgs-config.nix;
    overlays = import ./home-files/overlays.nix;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./home-files/nixpkgs-config.nix;
  xdg.configFile."nixpkgs/overlays.nix".source = ./home-files/overlays.nix;

  home = {
    file = {
      ".bazelrc".source = bazel-config;
    };
    packages = with pkgs; [
      # My custom packages
      my-emacs
      my-nvim

      awscli
      chromium
      gcc
      #haskellPackages.brittany
      haskellPackages.cabal2nix
      haskellPackages.hlint
      htop
      isabelle
      libreoffice
      nix-prefetch-git
      plantuml
      mupdf
      neovim-remote
      pciutils
      qdirstat
      shellcheck
      shfmt
      slack
      unzip
      weechat
      wget
      xdotool
    ];
    sessionVariables = {
      HM_PATH = https://github.com/rycee/home-manager/archive/master.tar.gz;
      LOCALE_ARCHIVE_2_11 = "${oldpkgs.glibcLocales}/lib/locale/locale-archive";
      LOCALE_ARCHIVE_2_27 = "${newpkgs.glibcLocales}/lib/locale/locale-archive";
      EDITOR = "${my-nvim}/bin/nvim";
    };
  };

  programs = {
    home-manager = {
      enable = true;
      path = "\$HM_PATH";
    };
    bash = {
      enable = true;
      shellAliases = {
        cb = "xclip -selection c";
        gd = "git diff";
        gl = "git log";
        gs = "git status";
        glol = "git log --graph --decorate --pretty=oneline --abbrev-commit";
        glola = "git log --graph --decorate --pretty=oneline --abbrev-commit --all";
        ll = "ls -lh";
        la = "ls -lAh";
      };
      historyControl = [ "ignoredups" ];
      historyIgnore = [ "ls" "ll" "exit" ];
      initExtra = ''
        # alt
        bind '"\e[1;3C":forward-word'
        bind '"\e[1;3D":backward-word'
        # shift
        bind '"\e[1;2C":forward-word'
        bind '"\e[1;2D":backward-word'

        # Window title magic
        # https://unix.stackexchange.com/questions/104018/set-dynamic-window-title-based-on-command-input
        function settitle () {
          if [[ -z ''${IN_NIX_SHELL} ]]; then
            echo -ne "\e]0;"; echo -n $BASH_COMMAND; echo -ne "\007"
          fi
        }
        if [[ "$SHELL" == *"/bin/bash" ]]; then
          case $TERM in
            rxvt*|*term)
            trap 'settitle' DEBUG
            export PS1="\e]0;$TERM\007$PS1"
          ;;
          esac
        fi

        unset LOCALE_ARCHIVE
      '';
    };
  };

  services = {
    unclutter = {
      enable = true;
      threshold = 10;
    };
  };

  systemd.user.sockets.xmobar = {
    Unit = {
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Socket = {
      ListenFIFO = "%h/.local/share/xmobar/xmobar.pipe";
    };
  };

  systemd.user.services.xmobar = {
    Unit = {
      Requires = "xmobar.socket";
      After = [
        "xmobar.socket"
      ];
    };

    Service = {
      ExecStart = "${pkgs.haskellPackages.xmobar}/bin/xmobar ${xmobar-config}";
      Restart = "always";
      StandardInput = "fd:xmobar.socket";
    };
  };

  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.feh}/bin/feh --no-fehbg --randomize --bg-center ~/.wallpaper/*
    '';
    profileExtra = ''
      ${pkgs.numlockx}/bin/numlockx on
      ${pkgs.xlibs.xset}/bin/xset -dpms
      ${pkgs.xlibs.xset}/bin/xset s off
      ${pkgs.xlibs.xrdb}/bin/xrdb ${xrdb-config}
      ${pkgs.autocutsel}/bin/autocutsel -s PRIMARY -buttonup -fork
    '';
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = xmonad-config;
      };
    };
  };
}
