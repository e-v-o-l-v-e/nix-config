{ inputs, ... }:
{
  flake.modules.homeManager.zen-browser = {
    imports = [
      inputs.zen-browser.homeModules.twilight
    ];

    programs.zen-browser.enable = true;
  };
}
