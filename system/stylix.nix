{
  pkgs,
  useStylix,
  lib,
  ...
}:
{
  environment.systemPackages = lib.optional useStylix pkgs.base16-schemes;
  stylix.enable = useStylix;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/emil.yaml";
}
