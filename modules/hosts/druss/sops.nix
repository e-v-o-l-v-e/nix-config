{ self, inputs, ... }:
let
  druss.sopsFile = "${inputs.secrets}/druss.yaml";
in
{
  flake.modules.nixos.druss-sops = {

    imports = [
      self.modules.nixos.sops
    ];

    secrets.password = druss // {
      neededForUsers = true;
    };
  };
}
