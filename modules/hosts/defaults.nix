{ inputs, lib, ... }:
{
  flake.modules.nixos.defaults =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        boot
        kernel
        keyboard
        locales
        net
        ssh
        time
      ];

      environment = {
        systemPackages = [
          pkgs.vim
          pkgs.fish
        ];

        variables = {
          EDITOR = lib.mkOverride 999 "vim";
        };
      };

      hardware.enableAllFirmware = true;
      hardware.enableRedistributableFirmware = true;
    };
}
