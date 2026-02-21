{ inputs, ... }:

{
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devshells =
        let
          mkShellConfig = name: packages: {
            inherit name;
            packages = packages ++ [ pkgs.fish ];
            bash.extra = "exec fish";
          };
        in
        {
          nvim-shell = mkShellConfig "nvim configuration shell" (
            with pkgs;
            [
              ccls
              clang
              cmake
              gcc
              gnumake
              laravel
              lua
              lua-language-server
              neovim
              nixd
              tree-sitter
            ]
          );

          c = mkShellConfig "c programming shell" (
            with pkgs;
            [
              bc
              binutils
              bison
              clang
              elfutils
              flex
              gcc
              getopt
              gnumake
              ncurses
              openssl
              pkg-config
              valgrind
              zlib
              ccls
            ]
          );

          dart = mkShellConfig "dart programming shell" [ pkgs.flutter ];

          java = mkShellConfig "java programming shell" (
            with pkgs;
            [
              gradle
              jdk
              jdt-language-server
              jre
            ]
          );

          lua = mkShellConfig "lua programming shell" (
            with pkgs;
            [
              lua-language-server
              lua
              love
            ]
          );

          python = mkShellConfig "python programming shell" (
            with pkgs;
            [
              python3
              python312Packages.matplotlib
              python312Packages.numpy
              python312Packages.pandas
              python3Packages.pip
            ]
          );

          php = mkShellConfig "php-programming-shell" (
            with pkgs;
            [
              laravel
              php
              phpactor
              php84Extensions.sqlite3
              php84Packages.composer
              sqlite
              sqlitebrowser
            ]
          );

          http-W41 = {
            name = "http server";

            packages = with pkgs; [
              bun
              openssl
              postman
              prisma
              prisma-engines
              prisma-language-server
              typescript
              typescript-language-server
              fish
            ];

            env = [
              { name = "PKG_CONFIG_PATH"; value = "${pkgs.openssl.dev}/lib/pkgconfig"; }
              { name = "PRISMA_SCHEMA_ENGINE_BINARY"; value = "${pkgs.prisma-engines}/bin/schema-engine"; }
              { name = "PRISMA_QUERY_ENGINE_BINARY"; value = "${pkgs.prisma-engines}/bin/query-engine"; }
              { name = "PRISMA_QUERY_ENGINE_LIBRARY"; value = "${pkgs.prisma-engines}/lib/libquery_engine.node"; }
              { name = "PRISMA_FMT_BINARY"; value = "${pkgs.prisma-engines}/bin/prisma-fmt"; }
              { name = "fish_history"; value = "w41"; }
            ];

            commands = [
              {
                name = "bun-install-dependencies";
                help = "Initialize bun libraries for the project";
                category = "setup";
                command = ''
                  bun install express superstruct validator @prisma/client @prisma/adapter-libsql
                  bun install -D @types/express prisma @types/validator
                '';
              }
              {
                name = "db-reset-push";
                help = "Generate Prisma client and push to DB";
                category = "database";
                command = "bunx prisma generate && bunx prisma db push && bunx prisma db seed";
              }
              {
                name = "db-reset-push-hard";
                help = "Hard reset DB, generate client, and push";
                category = "database";
                command = "bunx prisma generate && bunx prisma db push --force-reset && bunx prisma db seed";
              }
            ];

            bash.extra = ''
              echo "🛠️ W41 nix development shell"
            '';
          };
        };
    };
}
