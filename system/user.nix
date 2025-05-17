{
  pkgs,
  username,
  ...
}: {
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "evolve";
      extraGroups = [
        "audio"
        "docker"
        "input"
        "inputs"
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
    };

    defaultUserShell = pkgs.fish;
  };

  programs.fish.enable = true;
}
