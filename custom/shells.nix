{ pkgs }:
let
  useFish = ''
    export SHELL=${pkgs.fish}/bin/fish
    fish
    exit
  '';
in
{
  c = pkgs.mkShell {
    name = "c programming shell";
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

      fish
    ];

    shellHook = useFish;
  };

  dart = pkgs.mkShell {
    name = "dart programming shell";
    nativeBuildInputs = with pkgs; [
      flutter
      fish
    ];
    shellHook = useFish;
  };

  java = pkgs.mkShell {
    name = "java programming shell";
    nativeBuildInputs = with pkgs; [
      gradle
      jdk
      jdt-language-server
      jre

      fish
    ];
    shellHook = useFish;
  };

  lua = pkgs.mkShell {
    name = "lua programming shell";
    nativeBuildInputs = with pkgs; [
      lua-language-server
      lua

      fish
    ];
    shellHook = useFish;
  };

  python = pkgs.mkShell {
    name = "python programming shell";
    nativeBuildInputs = with pkgs; [
      python3
      python312Packages.matplotlib
      python312Packages.numpy
      python312Packages.pandas
      python3Packages.pip

      fish
    ];
    shellHook = useFish;
  };
}
