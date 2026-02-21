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
    };
  };
}
