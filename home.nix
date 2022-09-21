{ pkgs, ... }:
let inherit (pkgs) writeText;
in {
  imports = [
    (let
      x = builtins.fetchGit {
        url = "https://github.com/msteen/nixos-vscode-server";
        ref = "master";
        rev = "178c809a9dbd3f4df25ed7fbe23a52c35233502d";
      };
    in "${x}/modules/vscode-server/home.nix")
  ];

  nixpkgs = { config = { allowUnfree = true; }; };

  home = {
    username = "jordan";
    homeDirectory = "/home/jordan";
    stateVersion = "22.05";
    file = {
      ".tmux.conf" = {
        source = "${
            builtins.fetchGit {
              url = "https://github.com/gpakosz/.tmux";
              ref = "master";
              rev = "e865a8a1c1fd4f3e2ca0e3f45aab9e1ccabbead1";
            }
          }/.tmux.conf";
      };
    } // builtins.mapAttrs (n: _: { source = "${./home-files}/" + n; })
      (builtins.readDir ./home-files);

    packages = with pkgs; [
      # Command line
      bat
      git
      pciutils
      ripgrep
      unzip

      # Nix
      nixfmt
      statix

      # Shell
      shellcheck
      shfmt

      # Haskell
      cabal2nix
      haskellPackages.brittany

      # Coq
      coq
      coqPackages.mathcomp
      (pkgs.emacs.pkgs.withPackages (p: with p; [ proof-general ]))
    ];
    sessionVariables = {
      EDITOR = "vim";
      COQPATH =
        "$HOME/.nix-profile/lib/coq/${pkgs.coq.coq-version}/user-contrib";
      NIX_GHC_LIBDIR = "$(ghc --print-libdir)";
    };
  };

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        cb = "xclip -selection c";
        gd = "git diff";
        gdc = "git diff --cached";
        gl = "git log";
        glol = "git log --graph --decorate --pretty=oneline --abbrev-commit";
        glola =
          "git log --graph --decorate --pretty=oneline --abbrev-commit --all";
        gs = "git status";
        ll = "ls -lh";
        la = "ls -lAh";
      };
      historyControl = [ "ignoredups" ];
      historyIgnore = [ "ls" "la" "ll" "exit" ];
      initExtra = "";
    };
    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [ vim-nix ale ];

      extraConfig = (builtins.readFile "${
          builtins.fetchGit {
            url = "https://github.com/amix/vimrc";
            ref = "master";
            rev = "5108ca4ec066ed9b93bab2c7f5b0d37d244ac0a9";
          }
        }/vimrcs/basic.vim") + ''
          autocmd FileType nix let b:did_indent = 1
          let g:ale_fixers = {
          \  '*': ['remove_trailing_lines', 'trim_whitespace'],
          \  'nix': [
          \    'statix',
          \    'nixfmt',
          \  ],
          \  'sh': [
          \    'shfmt',
          \  ],
          \}
          let g:ale_fix_on_save = 1
        '';
    };
  };

  services = { vscode-server.enable = true; };
}
