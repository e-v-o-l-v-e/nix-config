{
  # REQUIRED MODULES [ opencloud ]
  flake.modules.nixos.radicale =
    { config, ... }:
    let
      cfg = config.server;
      host = "127.0.0.1:5232";
      radicaleDir = "${cfg.configPath}/radicale";
      collectionDir = "${radicaleDir}/collections";
    in
    {

      services.radicale = {
        user = cfg.serverUserName;
        group = cfg.serverGroupName;

        settings = {
          server = {
            hosts = [ host ];
            ssl = false; # disable SSL, only use when behind reverse proxy
          };
          auth = {
            type = "http_x_remote_user"; # disable authentication, and use the username that OpenCloud provides
          };
          web = {
            type = "none";
          };
          storage = {
            filesystem_folder = collectionDir;
            predefined_collections = builtins.toJSON {
              def-addressbook = {
                "D:displayname" = "OpenCloud Address Book";
                tag = "VADDRESSBOOK";
              };
              def-calendar = {
                "C:supported-calendar-component-set" = "VEVENT,VJOURNAL,VTODO";
                "D:displayname" = "OpenCloud Calendar";
                tag = "VCALENDAR";
              };
            };
          };
          logging = {
            # level = "debug"; # optional, enable debug logging
            bad_put_request_content = true; # only if level=debug
            request_header_on_debug = true; # only if level=debug
            request_content_on_debug = true; # only if level=debug
            response_content_on_debug = true; # only if level=debug
          };
        };
      };

      services.opencloud.settings.proxy.additional_policies = [
        {
          name = "default";
          routes = builtins.concatMap (
            service: map (
              endpoint: {
                inherit endpoint;
                backend = "http://${host}";
                remote_user_header = "X-Remote-User";
                skip_x_access_token = true;
                additional_headers = [ { "X-Script-Name" = "/${service}"; } ];
              }) [
                "/${service}/"
                "/.well-known/${service}"
              ])
            [
              "caldav"
              "carddav"
            ];
        }
      ];

      systemd.tmpfiles.rules = let
        inherit (config.services.radicale) user group;
      in [
        "d ${radicaleDir} 1775 ${user} ${group}"
        "d ${collectionDir} 1775 ${user} ${group}"
      ];
    };
}
