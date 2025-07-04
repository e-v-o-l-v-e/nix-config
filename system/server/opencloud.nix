{ config, ... }:
{
  services.opencloud = {
    # port = 9200;
    url = "https://test.cloud.imp-network.com";
    # stateDir = "${config.server.dataPath}/opencloud";
    stateDir = "/data/opencloud";
    user = "opencloud";
    group = "opencloud";
    environment = {
      OC_INSECURE = "true";
      PROXY_TLS = "false";
      OC_USERNAME = "admin";
      OC_PASSWORD = "admin";
      # IDM_ADMIN_PASSWORD = "admin";
      # ADMIN_PASSWORD = "admin";
    };
    environmentFile = "/services-config/opencloud.yml";
  };
}
