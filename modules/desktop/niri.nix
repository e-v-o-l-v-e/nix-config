{ inputs, ... }:
{
  flake.modules.nixos.niri-vimjoyer =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.vimjoyer.packages.${pkgs.stdenv.hostPlatform.system}.niri
      ];
    };
}
