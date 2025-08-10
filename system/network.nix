{
  hostname,
  config,
  username,
  lib,
  ...
}: let
  perso = config.personal.enable;
  secretsDir = ../secrets;
in {
  config = {
    networking = {
      hostName = hostname;
      networkmanager.enable = true;

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];

      firewall.allowedTCPPorts = lib.optionals config.server.enable config.server.openPorts;
    };

    services.openssh.enable = true;

    users.users.${username}.openssh.authorizedKeys.keys = [
      (builtins.readFile "${secretsDir}/public_keys/github.pub")
      (builtins.readFile "${secretsDir}/public_keys/git_unistra.pub")
    ];

    programs.localsend.enable = perso;

    # defined in host/${hostname}/configuration.nix
    services.tailscale = {};
    hardware.bluetooth = {};
  };

  options = {
    server.openPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 80 443 ];
      description = "List of ports to open";
    };

    server.staticAdress = lib.mkEnableOption "Enable static IPv4 address";

    server.vpn.enable = lib.mkEnableOption "Enable AirVPN over WireGuard";
  };
}


# test airvpn
# { config, pkgs, lib, ... }:
#
# let
#   cfg = config.server;
#
#   vpn = "airvpn";
#   namespace = "namespace-${vpn}";
#   vhost = "veth-host";
#   vns = "veth-${vpn}";
#   addressv4 = "10.142.178.59/32";
#   addressv6 = "fd7d:76ee:e68f:a993:8a1a:ff5d:d8f0:ecea/128";
# in
# {
#   config = {
#     networking.firewall.allowedTCPPorts = lib.optionals cfg.enable cfg.openPorts;
#
#     environment.systemPackages = lib.optionals cfg.vpn.enable [pkgs.wireguard-tools];
#
#     # networking.wireguard = lib.mkIf cfg.vpn.enable {
#     #   enable = true;
#     #   interfaces = {
#     #     "wg-${vpn}" = {
#     #       ips = [ addressv4 addressv6 ];
#     #       interfaceNamespace = namespace;
#     #
#     #       preSetup = ''
#     #         if ${pkgs.iproute2}/bin/ip netns list | grep -q ${namespace}; then
#     #           ${pkgs.iproute2}/bin/ip netns delete ${namespace}
#     #         fi
#     #
#     #         ${pkgs.iproute2}/bin/ip netns add ${namespace}
#     #         ${pkgs.iproute2}/bin/ip -n ${namespace} link set lo up
#     #
#     #         ${pkgs.iproute2}/bin/ip link add ${vhost} type veth peer name ${vns}
#     #         ${pkgs.iproute2}/bin/ip link set ${vns} netns ${namespace}
#     #         ${pkgs.iproute2}/bin/ip addr add 10.200.200.1/24 dev ${vhost}
#     #         ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip addr add 10.200.200.2/24 dev ${vns}
#     #         ${pkgs.iproute2}/bin/ip link set ${vhost} up
#     #         ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip link set ${vns} up
#     #         ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip route add default via 10.200.200.1
#     #       '';
#     #
#     #       postSetup = ''
#     #         ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip link set wg-${vpn} up
#     #       '';
#     #
#     #       postShutdown = ''
#     #         ${pkgs.iproute2}/bin/ip link del ${vhost}
#     #         ${pkgs.iproute2}/bin/ip netns delete ${namespace}
#     #       '';
#     #
#     #       peers = [
#     #         {
#     #           publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
#     #           endpoint = "ch3.vpn.airdns.org:1637";
#     #         }
#     #       ];
#     #     };
#     #   };
#     # };
#   };
#
# }
#
