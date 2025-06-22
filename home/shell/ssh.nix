{ ... }:
{
  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "github" = {
        host = "github.com";
        identityFile = "~/.ssh/keys/github";
      };
      "iut" = {
        host = "git.unistra.fr";
        identityFile = "~/.ssh/keys/git_unistra";
      };
    };
  };
}
