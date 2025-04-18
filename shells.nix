{pkgs}: let
  useFish = ''
    export SHELL=${pkgs.fish}/bin/fish
    fish
    exit
  '';
in {
  c = pkgs.mkShell {
    name = "c shell";
    nativeBuildInputs = with pkgs; [
      bc
      binutils
      bison
      clang
      elfutils
      fish
      flex
      gcc
      getopt
      gnumake
      ncurses
      openssl
      pkg-config
      valgrind
      zlib
    ];

    shellHook = useFish;
  };

  dart = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      flutter
    ];
  };

  java = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      jdk
      jre
    ];
    shellHook = useFish;
  };

  lua = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      lua-language-server
      lua
    ];
  };

  python = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      python3
      python312Packages.matplotlib
      python312Packages.numpy
      python312Packages.pandas
      python3Packages.pip
    ];

    shellHook = useFish;
  };
}
