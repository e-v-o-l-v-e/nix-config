{
  flake.modules.nixos.server =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.server;
    in
    {
      config = {
        environment.systemPackages = with pkgs; [
          bat-extras.batman
          btop
          dust
          ethtool
          gcc
          git
          iotop
          man-pages
          man-pages-posix
          nix-index
          openssl
          pay-respects
          smartmontools
        ];

        users.groups = lib.mkIf cfg.enable {
          ${cfg.serverGroupName} = {
            gid = cfg.serverGroupId;
            members = [ "evolve" ];
          };
        };

        users.users = lib.mkIf cfg.enable {
          ${cfg.serverUserName} = {
            name = cfg.serverUserName;
            uid = cfg.serverUserId;
            isSystemUser = true;
            group = cfg.serverGroupName;
            linger = cfg.enable;
          };
        };

        networking.firewall = {
          allowedTCPPorts = cfg.openPorts;

          extraCommands = lib.mkIf (cfg.allowedSubnets != [ ] && cfg.openPortsLocal != [ ]) (
            lib.concatStringsSep "\n" (
              lib.concatLists (
                map (
                  subnet:
                  map (
                    port: "iptables -A INPUT -p tcp -s ${subnet} --dport ${toString port} -j ACCEPT"
                  ) cfg.openPortsLocal
                ) cfg.allowedSubnets
              )
            )
          );
        };
      };

      options.server = with lib; {
        enable = mkEnableOption "server functionalities";

        configPath = mkOption {
          type = types.str;
          default = "/services-config";
          description = "path to the server's services config dir";
        };

        dataPath = mkOption {
          type = types.str;
          default = "/data";
          description = "path to the data dir";
        };

        ssdPath = mkOption {
          type = types.str;
          default = "/ssd";
          description = "path to the ssd data dir, for small frequently accessed files";
        };

        domain = mkOption {
          type = types.str;
          default = "example.com";
          description = "main FQDN";
        };

        domainSecondary = mkOption {
          type = types.str;
          default = "example.com";
          description = "secondary FQDN";
        };

        openPorts = mkOption {
          type = types.listOf types.int;
          default = [
            80
            443
          ];
          description = "ports to open in the firewall";
        };

        allowedSubnets = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = "subnets allowed to connect to openPortsLocal";
        };

        openPortsLocal = mkOption {
          type = types.listOf types.port;
          default = [
            8096 # jellyfin
            5055 # seerr
          ];
          description = "ports accessible from allowedSubnets";
        };

        vpn.enable = mkEnableOption "AirVPN over WireGuard";

        vpn.forwardedPort = mkOption {
          type = types.nullOr types.port;
          default = null;
          example = 18086;
          description = "port forwarded by the VPN provider";
        };

        serverGroupName = mkOption {
          type = types.str;
          default = "server";
          description = "group for media services (arr stack, jellyfin, etc.)";
        };

        serverGroupId = mkOption {
          type = types.int;
          default = 555;
        };

        serverUserName = mkOption {
          type = types.str;
          default = "server";
          description = "user for media services (arr stack, jellyfin, etc.)";
        };

        serverUserId = mkOption {
          type = types.int;
          default = 555;
        };
      };
    };
}
