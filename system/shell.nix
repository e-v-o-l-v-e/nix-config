{pkgs, ...}: {
  environment.shells = with pkgs; [fish bash];

  programs.pay-respects.enable = true;
  programs.nix-index.enable = true;

  programs.command-not-found.enable = false;
}
