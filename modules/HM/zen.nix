{
  inputs,
  useZen,
  lib,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];

  programs = lib.mkIf useZen {
    zen-browser = {
      enable = useZen;
    };
  };
}
