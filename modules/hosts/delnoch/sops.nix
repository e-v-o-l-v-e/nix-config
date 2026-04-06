{ self, inputs, ... }:
let
  delnoch.sopsFile = "${inputs.secrets}/delnoch.yaml";
  common.sopsFile = "${inputs.secrets}/common.yaml";
  server.sopsFile = "${inputs.secrets}/server.yaml";
in
{
  flake.modules.nixos.delnoch-sops = {
    imports = [
      self.modules.nixos.sops
    ];

    sops.secrets = {
      password = delnoch // {
        neededForUsers = true;
      };

      # services
      caddy-env = server // { owner = "caddy"; };
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
