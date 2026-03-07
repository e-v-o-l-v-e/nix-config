{ inputs, ... }:
let
  waylander.sopsFile = "${inputs.secrets}/waylander.yaml";
in
{
  flake.modules.nixos.waylander-sops = {

    imports = [
      inputs.modules.nixos.sops
    ];

    secrets.password = waylander // {
      neededForUsers = true;
    };
  };
}
