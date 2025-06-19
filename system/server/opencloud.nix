{config, ...}: let
  cfg = config.server.services.opencloud;
in {
  services.opencloud = {
    inherit (cfg) enable;
    port = 8100;
    url = "https://test.cloud.imp-network.com";
  };
}
