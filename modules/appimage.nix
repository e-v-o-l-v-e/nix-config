_: {
  flake.module.nixos.appimage = {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
