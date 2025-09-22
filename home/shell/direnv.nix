{ pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bash.enable = true;
  };

  programs.fish.interactiveShellInit = ''
    direnv hook fish | source
  '';

  home.packages = with pkgs; [ direnv nix-direnv hollywood ];
}
