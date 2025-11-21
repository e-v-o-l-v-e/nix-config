{ pkgs }:
let
  useFish = ''
    export SHELL=${pkgs.fish}/bin/fish
    fish
    exit
  '';
in
{
  nvim-shell = pkgs.mkShell {
    name = "nvim configuration shell";
    nativeBuildInputs = with pkgs; [
      ccls
      clang
      cmake
      fish
      gcc
      gnumake
      laravel
      lua
      lua-language-server
      neovim
      nixd
      tree-sitter
    ];

    shellHook = useFish;
  };

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
      ccls

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
      love

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
