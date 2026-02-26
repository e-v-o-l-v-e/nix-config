{ lib, ... }:
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
