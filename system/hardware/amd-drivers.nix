# 💫 https://github.com/JaKooLit 💫 #
{
  config,
  lib,
  pkgs,
  ...
}:let
  inherit (config) gpu;
in {
  config = lib.mkIf (gpu == "amd") {
    boot.initrd.kernelModules = lib.optional (gpu == "amd") "amdgpu";

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

  options = {
    gpu = lib.mkOption {
      type = lib.types.enum [
        "amd"
        "nvidia"
        "intel"
      ];
      default = "amd";
      description = "gpu type, to enable relevant drivers, currently only amd does something";
    };
  };
}
