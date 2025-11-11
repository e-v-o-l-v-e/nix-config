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
      "git_iut" = {
        host = "git.unistra.fr";
        identityFile = "~/.ssh/keys/git_unistra";
        addKeysToAgent = "yes";
      };
      "vps" = {
        host = "188.68.32.201";
        identityFile = "~/.ssh/keys/waylander";
        addKeysToAgent = "yes";
      };
      "iut" = {
        host = "sterne.iutrs.unistra.fr";
        identityFile = "~/.ssh/keys/waylander";
        addKeysToAgent = "yes";
      };
    };
  };
}
