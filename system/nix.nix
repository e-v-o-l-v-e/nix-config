{ inputs, config, username, ... }:
{
  # nix settings, nh, garbage cleaning
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 14d";
    flake = "home/${username}/${config.flakePath}";
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  documentation.man.generateCaches = false;

  programs.pay-respects.enable = true;
  programs.nix-index.enable = true;

  programs.command-not-found.enable = false;
}
