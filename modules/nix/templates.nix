{ self, ... }:
let
  templatesPath = ./_templates;
  getTemplate = template: templatesPath + "/${template}";
in
{
  flake.templates.default = self.templates.mini;

  flake.templates.mini = {
    path = getTemplate "mini";
    description = "Mini HM config";
    welcomeText = ''
      # mini HM config
      This config contains fish and some core packages

      ## Usage
      change the username and the system then run
      `nix run nixpkgs#home-manager -- switch .#your-username`

      this config is the mini one, see all available ones at https://github.com/e-v-o-l-v-e/nix-config/blob/flake-parts/modules/templates.nix
    '';
  };

  flake.templates.web-bun-express-prisma = {
    path = getTemplate "web-bun-express-prisma";
    description = "W41 shell";
    welcomeText = ''
      # HTTP web server
      This shell has bun, express, prisma all relevant packages and a install script for dependencies
      use `nix develop` to enter it
    '';
  };
}
