{ ... }:
{
  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      Host git.unistra.fr
        AddKeysToAgent yes
        IdentityFile ~/.ssh/keys/git_unistra

      Host github.com
        AddKeysToAgent yes
        IdentityFile ~/.ssh/keys/github
    '';
  };
}
