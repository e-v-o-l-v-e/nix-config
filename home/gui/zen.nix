{
  config,
  ...
}:
let
  cfg = config.soft.zen;
in 
{
  programs.zen-browser = {
    inherit (cfg) enable;
  };
}
