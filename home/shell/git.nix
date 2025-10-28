{username, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = username;
      user.email = "elivanoa5@gmail.com";
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
