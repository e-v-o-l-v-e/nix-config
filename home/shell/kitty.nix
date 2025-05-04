_: {
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      cursor_trail = 10;
    };
    environment = {
      "TERM" = "xterm-256color";
    };
  };
}
