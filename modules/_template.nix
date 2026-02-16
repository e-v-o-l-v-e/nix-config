{ self, ... }:
{
  templates.fish-config = {
    path = ./templates/_fish-config.nix;
    description = "Personnal shell config";
    welcomeText = ''
      # Simple Fish Shell config with common packages
    '';
  };
}
