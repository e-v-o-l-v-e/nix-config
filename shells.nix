{pkgs}: {
  c = pkgs.mkShell {
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

    buildInputs = with pkgs; [
      elfutils
      ncurses
      openssl
      zlib
      fish
    ];

    shellHook = ''
      export SHELL=${pkgs.fish}/bin/fish
      if [ -n "$IN_NIX_SHELL" ]; then
        exec fish
      fi
    '';
  };

  python = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      python3
      python3Packages.pip
      python312Packages.pandas
      python312Packages.numpy
      python312Packages.matplotlib
    ];

    shellHook = ''
      export SHELL=${pkgs.fish}/bin/fish
      fish
      exit
    '';
  };
}
