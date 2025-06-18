{ hostConfig, ... }:
{
  programs.git = {
    enable = true;
    userName = hostConfig.username;
    userEmail = "elivanoa5@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
