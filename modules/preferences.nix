{ inputs, lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options = {
    preferences = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "evolve";
      };

      keyboard = {
        layout = mkOption {
          type = types.str;
          default = "gb";
          description = "Keyboard layout";
        };
        variant = mkOption {
          type = types.str;
          default = "extd";
          example = null;
          description = "Keyboard layout variant";
        };
      };
    };
  };
}
