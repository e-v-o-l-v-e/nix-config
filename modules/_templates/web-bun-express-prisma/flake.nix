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
      db-reset-1 = "db-reseed";
      db-reset-2 = "db-reseed-force";

      abbr-1 = "re";
      abbr-2 = "ref";
      set-abbr = "set-abbr";
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
            ${getExe' pkgs.bun "bunx"} prisma migrate reset
            ${getExe' pkgs.bun "bunx"} prisma db seed 
          '';
          ${db-reset-2} = pkgs.writeShellScriptBin db-reset-2 ''
            ${getExe' pkgs.bun "bunx"} prisma migrate reset -f
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

          ${set-abbr} = pkgs.runCommand "fish-functions" { } ''
            mkdir -p $out/share/fish/vendor_functions.d
            echo "function ${set-abbr}
              abbr -a ${abbr-1} 'bunx prisma migrate reset; bunx prisma db seed'
              abbr -a ${abbr-2} 'bunx prisma migrate reset -f; bunx prisma db seed'
              echo '✅ fish abbreviations [${abbr-1}, ${abbr-2}] have been set for this session.'
            end" > $out/share/fish/vendor_functions.d/${set-abbr}.fish
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
            self.packages.${system}.${set-abbr}
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
              echo ""
              echo "[Scripts]"
              echo " - '${bun-dep}': install all dependencies with bun"
              echo " - '${db-reset-1}': reset db to last migration"
              echo " - '${db-reset-2}': force reset db to last migration"
              echo ""
              echo "[Shell]"
              echo "If you use fish you can use 'nix develop --command fish'"
              echo "and run ${set-abbr} to get the previous scripts as abbreviations: "
              echo " - '${abbr-1}': ${db-reset-1}"
              echo " - '${abbr-2}': ${db-reset-2}"
              echo "run 'nix develop --command fish -C ${set-abbr}' to get abbr from the start"
            '';
          };
        }
      );
    };
}
