[(self: super: rec {

  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghc802 = super.haskell.packages.ghc843.override {
        overrides = hself: hsuper:
        {
        };
      };
    };
  };

})]
