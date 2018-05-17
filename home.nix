{pkgs, ...}:
let
  inherit (pkgs) writeText;

  # Default font for various things
  xft-font = "Dejavu Sans Mono";

  # xmonad configuration values
  xmonad-follow-mouse = true;

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
    inherit pkgs; follow-mouse = xmonad-follow-mouse;
    inherit xmobar-config xmobar-title-color xmobar-workspace-color;
  });
  zathura-config = writeText "zathurarc" (import ./home-files/zathurarc.nix {
  });

in {

  nixpkgs = {
    config = import ./home-files/nixpkgs-config.nix;
    overlays = import ./home-files/overlays.nix;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./home-files/nixpkgs-config.nix;
  xdg.configFile."nixpkgs/overlays.nix".source = ./home-files/overlays.nix;
  xdg.configFile."zathura/zathurarc".source = zathura-config;

  home = {
    file = {
      ".bazelrc".source = bazel-config;
    };
    packages = with pkgs; [
      # My custom packages
      (import ./home-files/my-emacs.nix { inherit pkgs; })
      (import ./home-files/my-neovim.nix { inherit pkgs; })

      # Unmodified packages (unless modified in overlay?)
      shellcheck
      # Included by vimrc, but be explicit in case it changes
      zathura
      # For zathura to work nicely with Vimtex
      xdotool
    ];
    sessionVariables = {
      HM_PATH = https://github.com/rycee/home-manager/archive/master.tar.gz;
      NIX_PATH = "nixpkgs=/home/jordan/.nix-defexpr/nixpkgs/:nixos-config=/etc/nixos/configuration.nix";
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
