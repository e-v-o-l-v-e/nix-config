{ self, ... }:
let
  druss.sopsFile = "${self}/secrets/druss.yaml";
in
{
  flake.modules.nixos.druss-sops = {

    imports = [
      self.modules.nixos.sops
    ];

    sops.secrets.password = druss // {
      neededForUsers = true;
    };
  };
}
