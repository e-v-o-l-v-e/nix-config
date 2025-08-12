{
  inputs,
  config,
  username,
  lib,
  ...
}: let
  port = 3923;
in {
  imports = [inputs.copyparty.nixosModules.default];

  services.copyparty = {
    accounts = {
      "${username}" = {
      };
    };
  };

  services.caddy.virtualHosts = lib.mkIf config.services.copyparty.enable {
    "copyparty.${config.server.domain}" = {
      extraConfig = ''
      reverse_proxy http://localhost:${toString port}
      '';
    };
  };
}
