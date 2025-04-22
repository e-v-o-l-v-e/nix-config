{
  hostname,
  username,
  ...
}: let
  sysv = {
    waylander = "24.11";
  };
in {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = sysv."${hostname}" or "";
  };
  programs.home-manager.enable = true;
}
