{ username, ... }:
{
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "elivanoa5@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
