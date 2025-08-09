{config, ...}: let
  port = 8081;
in {
  # imports = [../../custom/modules/local-content-share.nix];

  # services.local-content-share = {
  #   inherit port;
  # };

  services.caddy.virtualHosts."quickshare.${config.server.domain}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
