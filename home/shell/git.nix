{ username, ... }:
{
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "elivanoa5@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";

      # url = {
      #   "ssh://git@ssh.github.com:443/" = {
      #     insteadOf = "git@github.com:";
      #   };
      # };
    };
  };
}
