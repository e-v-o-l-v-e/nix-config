{ lib, config, pkgs, ... }:
let
cfg = config.server;
fqdn = cfg.domain;

listenPort = 9513;
in
{
  config = 
  {
# Enable Podman
    virtualisation.podman = {
#   enable = true;
#   dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

# Create the Pod on boot
    systemd.services.init-heyform-pod = lib.mkIf cfg.docker.heyform.enable {
      description = "Create the Podman pod for HeyForm";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
# Create pod if it doesn't exist, mapping the web port
	${pkgs.podman}/bin/podman pod exists heyform-pod || \
	${pkgs.podman}/bin/podman pod create -n heyform-pod -p ${toString listenPort}:8000
	'';
    };

    virtualisation.oci-containers.backend = "podman";
    virtualisation.oci-containers.containers = lib.mkIf cfg.docker.heyform.enable {

# --- MongoDB Service ---
      mongo = {
	image = "percona/percona-server-mongodb:4.4";
	extraOptions = [ "--pod=heyform-pod" ];
	volumes = [
	  "/ssd/heyform/mongodb_data:/data/db"
	];
      };

# --- KeyDB Service ---
      keydb = {
	image = "eqalpha/keydb:x86_64_v6.3.4";
	extraOptions = [ "--pod=heyform-pod" ];
	cmd = [ "keydb-server" "--appendonly" "yes" "--protected-mode" "no" ];
	volumes = [
	  "/ssd/heyform/keydb:/data"
	];
      };

# --- HeyForm Service ---
      heyform = {
	image = "heyform/community-edition:latest";
	extraOptions = [ "--pod=heyform-pod" ];
	dependsOn = [ "mongo" "keydb" ];
	volumes = [
	  "/ssd/heyform/assets:/app/static/upload"
	];
	environment = {
	  APP_HOMEPAGE_URL = "https://form.${fqdn}";
	  SESSION_KEY = "key1";
	  FORM_ENCRYPTION_KEY = "key2";
# Note: In a Pod, services talk via 127.0.0.1
	  MONGO_URI = "mongodb://127.0.0.1:27017/heyform";
	  REDIS_HOST = "127.0.0.1";
	  REDIS_PORT = "6379";
	};
      };
    };

    services.caddy.virtualHosts = {
      "form.${fqdn}" = lib.mkIf cfg.docker.heyform.enable {
	extraConfig = ''
	  import cfdns
	  reverse_proxy http://localhost:${toString listenPort}
      '';
      };
    };
    systemd.services."podman-mongo" = {
      serviceConfig = {
	TimeoutStopSec = "12s";
# Force a clean shutdown request before killing
	ExecStop = lib.mkBefore [ "${pkgs.podman}/bin/podman stop -t 10 mongo" ];
      };
    };
  };
  options = {
    server.docker.heyform.enable = lib.mkEnableOption "enable heyform docker container";
  };
}
