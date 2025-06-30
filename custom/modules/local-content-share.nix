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
    enable = lib.mkEnableOption "Local-Content-Share";

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/local-content-share";
      description = "The path were all data will be stored";
    };

    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
      description = "Port on which the service will be available";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open choosen port";
    };

    package = mkOption {
      type = types.package;
      defaultText = literalExpression "inputs.local-content-share.packages.x86_64-linux.local-content-share";
      default = inputs.local-content-share.packages.x86_64-linux.local-content-share;
      description = "Local-Content-Share package to use";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.local-content-share = {
      description = "Local-Content-Share";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      environment = {
        HOME = cfg.dataDir;
      };

      serviceConfig = {
        Type = "simple";
        DynamicUser = true;
        StateDirectory = "local-content-share";
        WorkingDirectory = cfg.dataDir;
        ExecStart = "${lib.getExe' cfg.package "local-content-share"} -listen=:${toString cfg.port}";
        # ExecStart = "${inputs.local-content-share.packages.x86_64-linux.local-content-share.outPath}/bin/local-content-share -listen=:${toString cfg.port}";
        Restart = "on-failure";
      };
    };

    systemd.tmpfiles.rules = [ 
      "d ${cfg.dataDir} 0700"
    ];

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
  };
}
