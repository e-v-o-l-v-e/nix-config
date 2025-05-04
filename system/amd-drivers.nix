# 💫 https://github.com/JaKooLit 💫 #
{
  lib,
  pkgs,
  hostname,
  ...
}:
{
  config = lib.mkIf (hostname == "waylander" || hostname == "druss") {
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
