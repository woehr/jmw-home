[(self: super: {
  my = {
    neovim = import ./my-neovim.nix { pkgs = self; };
    emacs = import ./my-emacs.nix { pkgs = self; };
  };
})]
