{
  inputs,
  config,
  username,
  ...
}: let
  port = 3923;
in {
  imports = [inputs.copyparty.nixosModule.default];

  services.copyparty = {
    accounts = {
      "${username}" = {
      };
    };
  };

  services.caddy.virtualHosts."copyparty.${config.server.domainName}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
