# 💫 https://github.com/JaKooLit 💫 #
{
  lib,
  pkgs,
  gpu,
  ...
}: {
  config = lib.mkIf (gpu == "amd") {
    systemd.tmpfiles.rules = ["L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];
    services.xserver.videoDrivers = ["amdgpu"];

    # OpenGL
    hardware.graphics = {
      extraPackages = with pkgs; [
        libva
        libva-utils
      ];
    };
  };
}
