{
  inputs,
  useZen,
  lib,
  ...
}: {
  imports = lib.optional useZen inputs.zen-browser.homeModules.twilight;

  programs = lib.mkIf useZen {
    zen-browser = {
      enable = useZen;
    };
  };
}
