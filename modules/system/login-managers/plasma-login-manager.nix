{
  flake.modules.nixos.plasma-login-manager = {
    services.displayManager = {
      enable = true;
      plasma-login-manager.enable = true;
    };
  };
}
