{ self, ... }:
let
  delnoch.sopsFile = "${self}/secrets/delnoch.yaml";
  common.sopsFile = "${self}/secrets/common.yaml";
  server.sopsFile = "${self}/secrets/server.yaml";
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
      caddy-env = server // {
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
