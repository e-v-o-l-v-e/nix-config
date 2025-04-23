{
  pkgs,
  gaming,
  ...
}: let
  gamingPkgs = {
    full = with pkgs; [
      heroic-unwrapped
      steam
      steam-run
    ];
    simple = with pkgs; [
      steam
    ];
  };
in {
  home.packages = gamingPkgs.${gaming} or [];
}
