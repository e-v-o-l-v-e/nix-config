_: {
  flake.modules.nixos.greetd = {
    services.greetd = {
      enable = true;
    };
  };
}
