{config, ...}: {
  services.cloudflared = {
    tunnels = {
      "c24922c6-1db6-4533-b7c8-d684f4913f38" = {
        credentialsFile = "${config.sops.secrets.cloudflared-cred.path}";
        default = "http_status:404";
      };
    };
  };
}
