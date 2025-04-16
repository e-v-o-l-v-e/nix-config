{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "c shell";
}
