let
  getFontsPackages =
    pkgs: with pkgs; [
      cantarell-fonts
      carlito
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.daddy-time-mono
      jetbrains-mono
      font-awesome
      fira
    ];

in
{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = getFontsPackages pkgs;
    };

  flake.modules.homeManager.fonts =
    { pkgs, ... }:
    {
      home.packages = getFontsPackages pkgs;

      fonts.fontconfig.enable = true;
    };
}
