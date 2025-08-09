{ username, config, ... }: 
let
  listenPort = 3333;
  spaceDir = config.server.ssdPath + "/silverbullet/space";
  fqdn = config.server.domain;
in
  {
  services.silverbullet = {
    user = username;
    group = "users";
  
    inherit listenPort spaceDir;

    # envFile = spaceDir + "/../.env";
    envFile = "/etc/silverbullet.env";
  };

  services.caddy.virtualHosts."silverbullet.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString listenPort}
    '';
  };
}
