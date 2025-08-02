{
  inputs,
  config,
  username,
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

  services.caddy.virtualHosts."copyparty.${config.server.domain}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
