{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.kitty = lib.mkIf config.programs.kitty.nixConfig.enable {
      enableGitIntegration = true;

      settings = {
        cursor_trail = 10;
        window_padding_width = "2 5";
        allow_remote_control = "yes";
      };

      font = lib.mkForce {
        size = 12;
        name = "FiraCode";
      };

      # include potential color file, it won't give an error if it doesn't exists
      extraConfig = ''
        include colors.conf
      '';
    };

    # make all theme files easily accessible, you can then symlink the one you want
    # another option is using `kitten @ themes`
    xdg.configFile = lib.mkIf config.programs.kitty.nixConfig.enable {
      "kitty/themes".source = pkgs.kitty-themes + "/share/kitty-themes/themes";
    };
  };

  options = {
    programs.kitty.nixConfig.enable = lib.mkEnableOption "Enable nixified kitty config";
  };
}
