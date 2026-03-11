{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        carlito
        fira-code
        fira-code-symbols
        nerd-fonts.fira-code
        nerd-fonts.daddy-time-mono
        jetbrains-mono
        font-awesome
        fira
      ];
    };
}
