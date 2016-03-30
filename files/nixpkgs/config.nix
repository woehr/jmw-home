{
  allowUnfree = true;
  packageOverrides = super: rec {

  liquidGhc = super.pkgs.haskell.packages.ghc7102.ghcWithPackages
    (haskellPackages: with haskellPackages; [
      liquidhaskell
    ]);
  };
}

