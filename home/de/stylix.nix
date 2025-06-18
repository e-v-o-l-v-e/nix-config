{config, inputs, ...}: 
let
  cfg = config.gui.stylix;
in 
{
  imports = [ inputs.stylix.homeModules.stylix ];
}
