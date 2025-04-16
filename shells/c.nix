{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "c shell";
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
    fish # Include fish shell
  ];

  # Automatically start Fish shell when entering the nix develop environment
  shellHook = ''
    export SHELL=${pkgs.fish}/bin/fish
    if [ -n "$IN_NIX_SHELL" ]; then
      exec fish
    fi
  '';
}
