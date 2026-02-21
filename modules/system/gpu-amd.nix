{ pkgs, ... }:
{
  flake.modules.nixos.gpu-amd = {
    boot.initrd.kernelModules = "amdgpu";

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

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
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      volk
    ];

    kernelParams = [
      "splash"
      "quiet"
      "boot.shell_on_fail"
      "rd.systemd.show_status=auto"
      "udev.log_priority=3"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
    ];
  };
}
