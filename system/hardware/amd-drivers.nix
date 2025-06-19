# 💫 https://github.com/JaKooLit 💫 #
{
  config,
  lib,
  pkgs,
  ...
}:let
  inherit (config.hardware) gpu;
in {
  config = lib.mkIf (gpu == "amd") {
    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    # OpenGL
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          libva
          libva-utils
        ];
      };
      amdgpu.amdvlk.enable = true;
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      volk
    ];
  };
}
