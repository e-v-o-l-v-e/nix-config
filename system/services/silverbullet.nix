{ lib, username, config, ... }: 
let
  cfg = config.server;

  listenPort = 3333;
  spaceDir = cfg.ssdPath + "/silverbullet/space";
  fqdn = cfg.domain;
in
  {
  services.silverbullet = {
    user = username;
    group = "users";
  
    inherit listenPort spaceDir;

    # envFile = spaceDir + "/../.env";
    envFile = config.sops.secrets.silverbullet-env.path;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.silverbullet.enable {
    "silverbullet.${fqdn}" = {
      extraConfig = ''
      reverse_proxy http://localhost:${toString listenPort}
      '';
    };
  };

  systemd.tmpfiles.rules = lib.mkIf config.services.silverbullet.enable [ 
    "d ${cfg.ssdPath}/silverbullet 0775 silverbullet users -"
    "d ${spaceDir} 0775 silverbullet users -" 
    "Z ${cfg.configPath} 0775 silverbullet users -" 
  ];
}
