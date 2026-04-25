{
  flake.modules.nixos.user =
    { lib, ... }:
    {
      options.user = lib.mkOption {
        type = lib.types.str;
        default = "evolve";
        description = "name of the user of the system, needed by some scripts/services";
      };
    };
}
