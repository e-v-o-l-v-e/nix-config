{
  description = "http server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

      bun-dep = "bun-install-dependencies";
      db-reset-1 = "db-reset-push";
      db-reset-2 = "db-reset-push-hard";
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          inherit (pkgs.lib) getExe getExe';
        in
        {
          ${db-reset-1} = pkgs.writeShellScriptBin db-reset-1 ''
            ${getExe' pkgs.bun "bunx"} prisma generate
            ${getExe' pkgs.bun "bunx"} prisma db push
            ${getExe' pkgs.bun "bunx"} prisma db seed 
          '';
          ${db-reset-2} = pkgs.writeShellScriptBin db-reset-2 ''
            ${getExe' pkgs.bun "bunx"} prisma generate
            ${getExe' pkgs.bun "bunx"} prisma db push --force-reset
            ${getExe' pkgs.bun "bunx"} prisma db seed 
          '';
          ${bun-dep} = pkgs.writeShellScriptBin bun-dep ''
            ${getExe pkgs.bun} install express
            ${getExe pkgs.bun} install -D @types/express
            ${getExe pkgs.bun} install -D prisma
            ${getExe pkgs.bun} install @prisma/client
            ${getExe pkgs.bun} install @prisma/adapter-libsql
            ${getExe pkgs.bun} install superstruct
            ${getExe pkgs.bun} install validator
            ${getExe pkgs.bun} install -D @types/validator
          '';
          default = self.packages.${system}.${bun-dep};
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          custom-packages = [
            self.packages.${system}.${bun-dep}
            self.packages.${system}.${db-reset-1}
            self.packages.${system}.${db-reset-2}
          ];
        in
        {
          default = pkgs.mkShell {
            name = "http server";

            nativeBuildInputs =
              with pkgs;
              [
                bun
                openssl
                postman
                prisma
                prisma-engines
                prisma-language-server
                typescript
                typescript-language-server
              ]
              ++ custom-packages;

            shellHook = ''
              export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
              export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
              export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
              export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
              export PRISMA_FMT_BINARY="${pkgs.prisma-engines}/bin/prisma-fmt"

              export fish_history=w41

              echo ""
              echo "🛠️ W41 nix development shell"
              echo "init bun libraries etc with '${bun-dep}'"
              echo "db push reset scripts available as: [ ${db-reset-1}, ${db-reset-2} ]"
            '';
          };
        }
      );
    };
}
