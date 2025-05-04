{
  hostname,
  username,
  ...
}:
let
  sysv = {
    waylander = "24.11";
    druss = "25.05";
    delnoch = "25.05";
    wsl = "24.11";
  };
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = sysv."${hostname}" or "25.5";
  };
  programs.home-manager.enable = true;
}
