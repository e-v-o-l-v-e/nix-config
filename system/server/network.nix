{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.server;

  vpn = "airvpn";
  namespace = "namespace-${vpn}";
  vhost = "veth-host";
  vns = "veth-${vpn}";
  addressv4 = "10.142.178.59/32";
  addressv6 = "fd7d:76ee:e68f:a993:8a1a:ff5d:d8f0:ecea/128";
in {
  config = {
    networking.firewall.allowedTCPPorts = lib.optionals cfg.enable cfg.openPorts;

    # networking.interfaces = lib.mkIf cfg.staticAdress.enable {
    #   enp2s0 = {
    #     ipv4.addresses = [ {
    #         adress = "192.168.0.212";
    #         prefixLength = 24;
    #       } ];
    #   };
    # };

    # VPN CONFIG
    networking.wireguard.enable = cfg.vpn.enable;
    environment.systemPackages = lib.optionals cfg.vpn.enable [pkgs.wireguard-tools];

    networking.wireguard.interfaces = lib.mkIf cfg.vpn.enable {
      "wg-${vpn}" = {
        # privateKeyFile = config.sops.secrets."${vpn}/private_key".path;
        ips = [
          addressv4
          addressv6
        ];
        interfaceNamespace = namespace;

        # "wg-airvpn" est l'interface, elle est comprise dans le namespace, qui l'isole du reste de l'OS

        preSetup = ''
          if ${pkgs.iproute2}/bin/ip netns list | grep -q ${namespace}; then
            ${pkgs.iproute2}/bin/ip netns delete ${namespace}
          fi

          ${pkgs.iproute2}/bin/ip netns add ${namespace}
          ${pkgs.iproute2}/bin/ip -n ${namespace} link set lo up

          ${pkgs.iproute2}/bin/ip link add ${vhost} type veth peer name ${vns}
          ${pkgs.iproute2}/bin/ip link set ${vns} netns ${namespace}
          ${pkgs.iproute2}/bin/ip addr add 10.200.200.1/24 dev ${vhost}
          ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip addr add 10.200.200.2/24 dev ${vns}
          ${pkgs.iproute2}/bin/ip link set ${vhost} up
          ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip link set ${vns} up
          ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip route add default via 10.200.200.1
        '';
        # ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip link set wg-${vpn} up

        postSetup = ''
          ${pkgs.iproute2}/bin/ip netns exec ${namespace} ip link set wg-${vpn} up
        '';

        postShutdown = ''
          ${pkgs.iproute2}/bin/ip link del ${vhost}

          ${pkgs.iproute2}/bin/ip netns delete ${namespace}
        '';

        peers = [
          {
            publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
            # allowedIPs = [
            #   "0.0.0.0/0"
            #   "::/0"
            # ];
            endpoint = "ch3.vpn.airdns.org:1637";
          }
        ];
      };
    };
  };

  options = {
    server.openPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [
        80
        443
      ];
      description = "List of ports to open";
    };

    server.staticAdress = lib.mkEnableOption "Enable static IPv4 address";

    server.vpn.enable = lib.mkEnableOption "Enable connection with airvpn through wireguard for a server config";
  };
}
