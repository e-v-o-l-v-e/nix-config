{ self, lib, ... }: let
  username = "evolve";
in  {
  flake.modules = lib.mkMerge [
    (self.lib.mkUser username true)
    (self.lib.mkHomeManager { })
  ];
}
