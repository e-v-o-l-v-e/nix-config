{ personal, ... }:
{
  programs.kitty = {
    enable = personal;
    enableGitIntegration = true;
    settings = {
      cursor_trail = 10;
      window_padding_width = "2 5";
    };
  };
}
