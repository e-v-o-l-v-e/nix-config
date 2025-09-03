{ username, ... }:
{
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "elivanoa5@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      pull.ff = "only";

      # url = {
      #   "ssh://git@ssh.github.com:443/" = {
      #     insteadOf = "git@github.com:";
      #   };
      # };
    };
  };
}
