{
  inputs,
  hostConfig,
  lib,
  ...
}:
let
  cfg = hostConfig.soft.zen;
in 
{
  imports = lib.optional cfg.enable inputs.zen-browser.homeModules.twilight;

  programs.zen-browser = {
    inherit (cfg) enable;
  };
}
