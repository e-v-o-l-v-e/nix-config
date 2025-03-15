{
  description = "Flake for a C programming environment with Fish shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";  # You can pin a specific version if desired
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "C coding";

        # Native build inputs for compiling and building C programs
        nativeBuildInputs = with pkgs; [
          getopt
          flex
          bison
          gcc
          gnumake
          bc
          pkg-config
          valgrind
          binutils
        ];

        # Build inputs for libraries and tools
        buildInputs = with pkgs; [
          elfutils
          ncurses
          openssl
          zlib
          fish  # Include fish shell
        ];

        # Automatically start Fish shell when entering the nix develop environment
        shellHook = ''
          export SHELL=${pkgs.fish}/bin/fish
          if [ -n "$IN_NIX_SHELL" ]; then
            exec fish
          fi
        '';
      };
    };
}

