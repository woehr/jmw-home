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
      (import ./home-files/my-emacs.nix { inherit pkgs; })
      (import ./home-files/my-neovim.nix { inherit pkgs; })

      htop
      mupdf
      neovim-remote
      shellcheck
      shfmt
      unzip
      wget
      xdotool
    ];
    sessionVariables = {
      HM_PATH = https://github.com/rycee/home-manager/archive/master.tar.gz;
      NIX_PATH = "nixpkgs=/home/jordan/.nix-defexpr/nixpkgs/:nixos-config=/etc/nixos/configuration.nix";
      LOCALE_ARCHIVE_2_11 = "${oldpkgs.glibcLocales}/lib/locale/locale-archive";
      LOCALE_ARCHIVE_2_27 = "${newpkgs.glibcLocales}/lib/locale/locale-archive";
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
        ll = "ls -lAh";
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
