{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
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
}
