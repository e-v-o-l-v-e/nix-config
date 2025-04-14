{pkgs, ...}: {
  users.packages = with pkgs; [
    clang
    jdk
    jdt-language-server
    jre
    lua-language-server
  ];
}
