{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

with lib;

let
  cfg = config.services.local-content-share;
in
{
  options.services.local-content-share = {
    enable = mkEnableOption "Local-Content-Share";

    dataDir = mkOption {
      type = types.str;
      default = "/var/lib/local-content-share";
      description = "The path were all data will be stored";
    };

    port = mkOption {
      type = types.int;
      default = 8080;
      description = "Port on which the service will be available";
      example = 3000;
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Open choosen port";
      example = true;
    };

    package = mkOption {
      type = types.package;
      defaultText = literalExpression "inputs.local-content-share.packages.x86_64-linux.local-content-share";
      default = inputs.local-content-share.packages.x86_64-linux.local-content-share;
      description = "Local-Content-Share package to use";
      example = pkgs.local-content-share;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.local-content-share = {
      description = "Local-Content-Share";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        DynamicUser = true;
        StateDirectory = "local-content-share";
        WorkingDirectory = cfg.dataDir;
        ExecStart = "${getExe' cfg.package "local-content-share"} -listen=:${toString cfg.port}";
        Restart = "on-failure";
      };
    };

    systemd.tmpfiles.rules = [ 
      "d ${cfg.dataDir} 0700"
    ];

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
  };
}
