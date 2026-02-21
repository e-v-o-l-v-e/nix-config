{ inputs, ... }:
let
  delnoch.sopsFile = "${inputs.secrets}/delnoch.yaml";
  common.sopsFile = "${inputs.secrets}/common.yaml";
  server.sopsFile = "${inputs.secrets}/server.yaml";
in
{
  flake.modules.nixos.delnoch-sops = {

    imports = [
      inputs.modules.nixos.sops
    ];

    sops.password = delnoch;
  };

  flake.modules.homeManager.delnoch-sops = {

    imports = [
      inputs.modules.homeManager.sops
    ];

    sops.secrets = {

      # services
      caddy-env = {
        inherit (server) sopsFile;
        owner = "caddy";
      };
      silverbullet-env = server;
      kavita-token = server;
      navidrome-env = server;
      "slskd.env" = server;

      # network
      cloudflared-cred = server;
      "wg-airvpn.conf" = server;
      "airvpn/private_key" = common;
      "airvpn/preSharedKey" = common;
    };
  };
}
