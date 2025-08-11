{ ... }:
{
  programs.pay-respects = {
    enable = true;
    enableFishIntegration = true;

  };

  home.file.".config//pay-respects/config.toml".text = ''
    timeout = 3000
    [package_manager]
    package_manager = "nix"
    install_method = "Shell"
  '';

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
