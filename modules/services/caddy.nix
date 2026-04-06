{
  flake.modules.nixos.caddy =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      plugins = [ "github.com/caddy-dns/cloudflare" ];
      goImports = lib.flip lib.concatMapStrings plugins (pkg: "   _ \"${pkg}\"\n");
      goGets = lib.flip lib.concatMapStrings plugins (pkg: "go get ${pkg}\n      ");
      main = ''
        package main
        import (
        	caddycmd "github.com/caddyserver/caddy/v2/cmd"
        	_ "github.com/caddyserver/caddy/v2/modules/standard"
        ${goImports}
        )
        func main() {
        	caddycmd.Main()
        }
      '';

      caddy-cloudflare = pkgs.buildGo125Module {
        pname = "caddy-cloudflare";
        version = pkgs.caddy.version;
        runVend = true;
        subPackages = [ "cmd/caddy" ];
        src = pkgs.caddy.src;
        vendorHash = "sha256-5wcj1IMYR/9p8twzlPbNHnpImAOnh5wuudnItwYBFeA=";
        overrideModAttrs = (
          _: {
            preBuild = ''
              echo '${main}' > cmd/caddy/main.go
              ${goGets}
            '';
            postInstall = "cp go.sum go.mod $out/ && ls $out/";
          }
        );
        postPatch = ''
          echo '${main}' > cmd/caddy/main.go
        '';
        postConfigure = ''
          cp vendor/go.sum ./
          cp vendor/go.mod ./
        '';
        meta = pkgs.caddy.meta // {
          mainProgram = "caddy";
        };
      };
    in
    {
      services.caddy = {
        package = caddy-cloudflare;

        globalConfig = ''
          acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
        '';

        extraConfig = ''
          (cfdns) {
            tls {
              dns cloudflare {env.CLOUDFLARE_API_TOKEN}
              resolvers 1.1.1.1
            }
          }
        '';
      };

      systemd.services = lib.mkIf config.services.caddy.enable {
        caddy.serviceConfig = {
          EnvironmentFile = config.sops.secrets.caddy-env.path;
          AmbientCapabilities = "CAP_NET_BIND_SERVICE";
          TimeoutStartSec = "5s";
        };
      };
    };
}
