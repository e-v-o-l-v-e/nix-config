{
  pkgs,
  hostname,
  ...
}: let
  pkgPerHost = {
    druss = with pkgs; [
      heroic-unwrapped
      steam
      steam-run
    ];
    waylander = with pkgs; [
      steam
    ];
  };
in {
  home.packages = pkgPerHost.${hostname} or [];
}
