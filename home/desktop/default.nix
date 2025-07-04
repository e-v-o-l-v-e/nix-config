{ lib, ... }:
{
  imports = [
    ./hypr
    ./fonts.nix
    ./quickshell
    ./stylix.nix
  ];

  options = {
    gui = {
      theme = lib.mkOption {
        type = lib.types.enum [
          "dark"
          "light"
        ];
        default = "light";
      };
    };
  };
}
