{ config, ...}:let
  port = 8081;
in {
  services.local-content-share = {
    inherit port;
  };

  services.caddy.virtualHosts."quickshare.${config.server.domainName}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
