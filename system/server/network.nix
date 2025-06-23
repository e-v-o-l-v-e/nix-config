{ config, pkgs, ...}: {

  networking.firewall.allowedUDPPorts = [ 80 443 ];

  networking.nat.enable = true;
  networking.nat.externalIP = "eth0";
  networking.nat.internalIPs = [ "wg0" ];

  # environment.systemPackges = [ pkgs.wireguard-tools ];
  # networking.wireguard.enable = true;
  # networking.wireguard.interfaces = { 
  #   wg0 = {
  #     privateKey = config.sops.secrets;
  #   };
  # };

  networking.wg-quick.interfaces = { 
    wg0 = {
      address = [ "192.168.2.212/24" ];
      listenPort = 51820;
      privateKey = config.sops.secrets."private_key/airvpn";

      peers = [{
        publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
        allowedIPs = [ "0.0.0.0" ];
        Endpoint = "ch3.vpn.airdns.org:1637";
      }];
    };
  };
}
