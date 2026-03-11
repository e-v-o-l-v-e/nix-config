{
  flake.modules.homeManager.git =
    { config, ... }:
    {
      programs.git = {
        enable = true;
        lfs.enable = true;

        settings = {
          user.name = config.home.username;
          user.email = "git@catch.imp-network.com";
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
    };
}
