{ ... }:
{
  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github" = {
        host = "github.com";
        identityFile = "~/.ssh/keys/github";
        addKeysToAgent = "yes";
      };
      "iut" = {
        host = "git.unistra.fr";
        identityFile = "~/.ssh/keys/git_unistra";
        addKeysToAgent = "yes";
      };
    };
  };
}
