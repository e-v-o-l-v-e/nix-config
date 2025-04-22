{
  hostname,
  username,
  ...
}: let
  sysv = {
    waylander = "24.11";
    druss = "24.11";
    wsl = "24.11";
  };
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = sysv."${hostname}" or "";
  };
  programs.home-manager.enable = true;
}
