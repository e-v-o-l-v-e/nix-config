{
  inputs,
  hostname,
  lib,
  ...
}: let
  useZen = hostname != "delnoch" && hostname != "wsl";
in {
  imports = lib.optional useZen inputs.zen-browser.homeModules.twilight;

  programs.zen-browser = {
    enable = useZen;
  };
}
