[(self: super: rec {
  # synctexSupport is currently the default but make sure that
  # doesn't change
  zathura = super.zathura.override { synctexSupport = true;};

  python = super.python.override {
    packageOverrides = python-self: python-super: {
      pygments = python-super.pygments.overrideAttrs ( oldAttrs: {
        src = /home/jordan/repos/pygments;
      });
    };
  };
  pythonPackages = python.pkgs;

})]
