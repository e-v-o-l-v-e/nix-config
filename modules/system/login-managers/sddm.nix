{
  flake.modules.nixos.sddm = {
    services.displayManager = {
      enable = true;
      sddm.enable = true;
    };
  };
}
