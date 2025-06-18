{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = config.username;
    userEmail = "elivanoa5@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
