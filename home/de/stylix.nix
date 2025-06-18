{config, inputs, lib, ...}: 
let
  cfg = config.gui.stylix;
in 
{
  imports = lib.optionals cfg.enable inputs.stylix.homeModules.stylix;
}
