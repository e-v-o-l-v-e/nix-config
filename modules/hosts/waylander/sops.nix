{ self, ... }:
let
  waylander.sopsFile = "${self}/secrets/waylander.yaml";
in
{
  flake.modules.nixos.waylander-sops = {

    imports = [
      self.modules.nixos.sops
    ];

    sops.secrets.password = waylander // {
      neededForUsers = true;
    };
  };
}
