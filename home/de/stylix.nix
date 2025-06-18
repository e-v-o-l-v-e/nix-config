{hostConfig, inputs, lib, ...}: 
let
  cfg = hostConfig.gui.stylix;
in 
{
  imports = lib.optionals cfg.enable inputs.stylix.homeModules.stylix;
}
