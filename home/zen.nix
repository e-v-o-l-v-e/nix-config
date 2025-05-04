{
  inputs,
  personal,
  zen-browser,
  hostname,
  lib,
  ...
}:
{
  imports = lib.optional personal inputs.zen-browser.homeModules.twilight;

  programs.zen-browser.enable = personal;
}
