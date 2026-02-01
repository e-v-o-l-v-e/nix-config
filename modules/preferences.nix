{ pkgs, ... }:
{
  flake.nixosModules.user =
    let
      username = "evolve";

      extraGroups = [
        "audio"
        "docker"
        "input"
        "inputs"
        "key"
        "kvm"
        "libvirtd"
        "lp"
        "networkmanager"
        "scanner"
        "uinputs"
        "users"
        "video"
        "wheel"
      ];
    in
    {
      users = {
        mutableUsers = true;
        users.${username} = {
          isNormalUser = true;
          homeMode = "700";
          inherit extraGroups;
          home = "/home/${username}";
          linger = true;
        };
        defaultUserShell = pkgs.fish;
      };

      environment.shells = with pkgs; [
        fish
        bash
      ];

      programs.fish.enable = true;

      # sops.secrets = lib.mkIf cfg.enable {
      #   "password-${hostname}".neededForUsers = true;
      # };
    };
}
