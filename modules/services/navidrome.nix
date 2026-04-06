{
  flake.modules.nixos.navidrome =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.server;
      fqdn = cfg.domain;
      port = 4533;
    in
    {
      services.navidrome = {
        user = cfg.serverUserName;
        group = cfg.serverGroupName;
        openFirewall = true;
        environmentFile = config.sops.secrets.navidrome-env.path;
        settings = {
          inherit port;
          Address = "0.0.0.0";
          MusicFolder = "${cfg.dataPath}/media/music";
          BaseUrl = "https://navidrome.${cfg.domain}";
        };
      };

      environment.systemPackages = lib.mkIf config.services.navidrome.enable [ pkgs.beets ];

      services.caddy.virtualHosts = lib.mkIf config.services.navidrome.enable {
        "navidrome.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString port}
        '';
      };
    };
}
