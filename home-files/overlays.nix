[(self: super: {
  # synctexSupport is currently the default but make sure that
  # doesn't change
  zathura = super.zathura.override { synctexSupport = true;};
})]
