{
  pkgs,
  username,
  hostname,
  config,
  ...
}:
let
  extraGroups = [ 
    "audio" "docker" "input" "inputs"
    "kvm" "libvirtd" "lp" "networkmanager"
    "scanner" "uinputs" "users" "video" "wheel"
    config.server.mediaGroupName
  ];
in
{
  users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      homeMode = "700";
      inherit extraGroups;
      home = "/home/${username}";
      hashedPasswordFile = config.sops.secrets."password-${hostname}".path;
    };
    defaultUserShell = pkgs.fish;
  };
  environment.shells = with pkgs; [
    fish
    bash
  ];

  programs.fish.enable = true;

  sops.secrets."password-${hostname}".neededForUsers = true;
  # users must not be mutable if you want to configure your password with sops
  # users.mutableUsers = lib.mkIf cfg.enable (lib.mkForce false);
}
